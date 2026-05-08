import React, { useState, useEffect, useRef } from 'react';
import {
  Layout,
  Card,
  Table,
  Button,
  Modal,
  Form,
  Input,
  InputNumber,
  message,
  Spin,
  Tag,
  Space,
  Typography,
  Divider,
  Empty,
  Row,
  Col,
  Statistic,
  List,
  Badge,
  Tooltip,
  Popconfirm,
  Switch,
  Alert,
  Select
} from 'antd';
import {
  PlusOutlined,
  DeleteOutlined,
  ReloadOutlined,
  PlayCircleOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
  ExclamationCircleOutlined,
  ClockCircleOutlined,
  DatabaseOutlined,
  ExperimentOutlined,
  SyncOutlined,
  BugOutlined
} from '@ant-design/icons';

const { Header, Content, Sider } = Layout;
const { Title, Text } = Typography;
const { Option } = Select;

// API базовый URL
const API_BASE_URL = 'http://localhost:8000';

// Статусы тестов с конфигурацией
const resultConfig = {
  VALID: { color: 'success', icon: <CheckCircleOutlined />, label: 'VALID' },
  INVALID: { color: 'error', icon: <CloseCircleOutlined />, label: 'INVALID' },
  ERROR: { color: 'default', icon: <ExclamationCircleOutlined />, label: 'ERROR' },
  UNKNOWN: { color: 'warning', icon: <ClockCircleOutlined />, label: 'UNKNOWN' },
  generated: { color: 'processing', icon: <SyncOutlined spin />, label: 'GENERATED' }
};

function App() {
  const [testRuns, setTestRuns] = useState([]);
  const [selectedTestRun, setSelectedTestRun] = useState(null);
  const [tests, setTests] = useState([]);
  const [loading, setLoading] = useState(false);
  const [loadingTests, setLoadingTests] = useState(false);
  const [modalVisible, setModalVisible] = useState(false);
  const [singleTestModalVisible, setSingleTestModalVisible] = useState(false);
  const [testResult, setTestResult] = useState(null);
  const [autoRefresh, setAutoRefresh] = useState(true);
  const [lastUpdate, setLastUpdate] = useState(null);
  const [form] = Form.useForm();
  const [singleTestForm] = Form.useForm();
  const intervalRef = useRef(null);
  
  // Данные для select'ов из API
  const [aggregationData, setAggregationData] = useState([]);
  const [loadingAggregation, setLoadingAggregation] = useState(false);
  const [selectedStationForTest, setSelectedStationForTest] = useState('');
  const [availableTypes, setAvailableTypes] = useState([]);
  const [availableObjects, setAvailableObjects] = useState([]);
  const [availableVariables, setAvailableVariables] = useState([]);
  const [availableValues, setAvailableValues] = useState([]);

  // Загрузка агрегированных объектов для выбранной станции
  const loadAggregationObjects = async (station) => {
    if (!station) return;
    
    setLoadingAggregation(true);
    try {
      const response = await fetch(`${API_BASE_URL}/api/get_aggregation_objects?station=${station}&limit=0`);
      if (!response.ok) throw new Error('Ошибка загрузки данных');
      const data = await response.json();
      setAggregationData(data);
      
      // Извлекаем уникальные типы
      const types = [...new Set(data.map(item => item.type))];
      setAvailableTypes(types);
      
      return data;
    } catch (error) {
      message.error(error.message);
      return [];
    } finally {
      setLoadingAggregation(false);
    }
  };

  // Обработчик изменения станции в форме одиночного теста
  const handleStationChange = async (station) => {
    setSelectedStationForTest(station);
    setAvailableObjects([]);
    setAvailableVariables([]);
    setAvailableValues([]);
    singleTestForm.setFieldsValue({
      type: undefined,
      object_name: undefined,
      variable: undefined,
      value: undefined
    });
    
    if (station) {
      const data = await loadAggregationObjects(station);
      if (data && data.length > 0) {
        // Если есть данные, автоматически выбираем первый тип
        const firstType = data[0].type;
        singleTestForm.setFieldsValue({ type: firstType });
        handleTypeChange(firstType, data);
      }
    }
  };

  // Обработчик изменения типа объекта
  const handleTypeChange = (type, data = aggregationData) => {
    const typeData = data.find(item => item.type === type);
    if (typeData) {
      setAvailableObjects(typeData.objects || []);
      setAvailableVariables(Object.keys(typeData.variables || {}));
      setAvailableValues([]);
      singleTestForm.setFieldsValue({
        object_name: undefined,
        variable: undefined,
        value: undefined
      });
    } else {
      setAvailableObjects([]);
      setAvailableVariables([]);
      setAvailableValues([]);
    }
  };

  // Обработчик изменения переменной
  const handleVariableChange = (variable) => {
    const selectedType = singleTestForm.getFieldValue('type');
    const typeData = aggregationData.find(item => item.type === selectedType);
    
    if (typeData && typeData.variables && typeData.variables[variable]) {
      const variableValues = typeData.variables[variable];
      setAvailableValues(variableValues);
      // Автоматически выбираем первое значение, если оно есть
      if (variableValues && variableValues.length > 0) {
        singleTestForm.setFieldsValue({ value: variableValues[0].value });
      }
    } else {
      setAvailableValues([]);
    }
  };

  // Загрузка списка тестовых запусков
  const loadTestRuns = async () => {
    setLoading(true);
    try {
      const response = await fetch(`${API_BASE_URL}/api/get_tests_runs`);
      if (!response.ok) throw new Error('Ошибка загрузки тестовых запусков');
      const data = await response.json();
      setTestRuns(data);
      if (data.length > 0 && !selectedTestRun) {
        setSelectedTestRun(data[0]);
      }
    } catch (error) {
      message.error(error.message);
    } finally {
      setLoading(false);
    }
  };

  // Загрузка деталей тестового запуска через новый маршрут
  const loadTestRunDetails = async (testRun) => {
    if (!testRun || !testRun.tests_id || testRun.tests_id.length === 0) return;
    
    setLoadingTests(true);
    try {
      const idsString = testRun.tests_id.join(',');
      const response = await fetch(`${API_BASE_URL}/api/get_tests_by_ids?id_test=${idsString}`);
      
      if (!response.ok) throw new Error('Ошибка загрузки тестов');
      const data = await response.json();
      setTests(data);
      setLastUpdate(new Date());
    } catch (error) {
      message.error(error.message);
      setTests([]);
    } finally {
      setLoadingTests(false);
    }
  };

  // Загрузка деталей текущего выбранного запуска
  const refreshCurrentTestRun = async () => {
    if (selectedTestRun && autoRefresh) {
      await loadTestRunDetails(selectedTestRun);
    }
  };

  // Генерация тестового запуска
  const generateTestRun = async (values) => {
    const { station, count } = values;
    setLoading(true);
    try {
      const response = await fetch(
        `${API_BASE_URL}/api/generate_test_run?station=${station}&count=${count}`,
        { method: 'POST' }
      );
      if (!response.ok) throw new Error('Ошибка генерации тестового запуска');
      const data = await response.json();
      message.success('Тестовый запуск успешно создан');
      setModalVisible(false);
      form.resetFields();
      await loadTestRuns();
      setSelectedTestRun(data);
      await loadTestRunDetails(data);
    } catch (error) {
      message.error(error.message);
    } finally {
      setLoading(false);
    }
  };

  // Создание и запуск одиночного теста
  const createAndRunSingleTest = async (values) => {
    setLoading(true);
    setTestResult(null);
    try {
      const response = await fetch(`${API_BASE_URL}/api/create_test`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(values)
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.detail || 'Ошибка создания теста');
      }
      
      const data = await response.json();
      message.success(data.message || 'Тест успешно создан и выполнен');
      setTestResult(data);
      
      // Обновляем текущий тестовый запуск, если он выбран
      if (selectedTestRun) {
        setTimeout(async () => {
          await loadTestRunDetails(selectedTestRun);
          await loadTestRuns();
        }, 1000);
      }
      
    } catch (error) {
      message.error(error.message);
      setTestResult({ 
        status: 'error', 
        message: error.message,
        result: 'ERROR'
      });
    } finally {
      setLoading(false);
    }
  };

  // Запуск тестов
  const runTests = async (testRunId) => {
    setLoading(true);
    try {
      const response = await fetch(`${API_BASE_URL}/api/tests_run?id_run=${testRunId}`, 
        { method: 'POST' }
      );
      if (!response.ok) throw new Error('Ошибка запуска тестов');
      message.success('Тесты успешно запущены');
      setTimeout(async () => {
        await loadTestRunDetails(selectedTestRun);
        await loadTestRuns();
      }, 2000);
    } catch (error) {
      message.error(error.message);
    } finally {
      setLoading(false);
    }
  };

  // Удаление всех тестов
  const deleteAllTests = async () => {
    setLoading(true);
    try {
      const response = await fetch(`${API_BASE_URL}/api/drop_tests_collection`, 
        { method: 'DELETE' }
      );
      if (!response.ok) throw new Error('Ошибка удаления тестов');
      message.success('Все тесты успешно удалены');
      await loadTestRuns();
      setSelectedTestRun(null);
      setTests([]);
    } catch (error) {
      message.error(error.message);
    } finally {
      setLoading(false);
    }
  };

  // Выбор тестового запуска
  const handleSelectTestRun = (testRun) => {
    setSelectedTestRun(testRun);
    loadTestRunDetails(testRun);
  };

  // Форматирование даты
  const formatDate = (timestamp) => {
    if (!timestamp) return 'Не запущен';
    const date = new Date(timestamp * 1000);
    return date.toLocaleString('ru-RU', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });
  };

  // Получение статуса теста
  const getResultStatus = (result) => {
    return resultConfig[result] || resultConfig.UNKNOWN;
  };

  // Статистика по тестам
  const getTestStatistics = () => {
    const stats = {
      total: tests.length,
      valid: tests.filter(t => t.result === 'VALID').length,
      invalid: tests.filter(t => t.result === 'INVALID').length,
      error: tests.filter(t => t.result === 'ERROR').length,
      generated: tests.filter(t => t.result === 'generated').length,
      unknown: tests.filter(t => !t.result || t.result === 'UNKNOWN').length
    };
    return stats;
  };

  // Настройка интервала автообновления
  useEffect(() => {
    if (autoRefresh && selectedTestRun) {
      intervalRef.current = setInterval(() => {
        refreshCurrentTestRun();
      }, 10000);
    } else {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    }

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    };
  }, [autoRefresh, selectedTestRun]);

  useEffect(() => {
    loadTestRuns();
  }, []);

  useEffect(() => {
    if (selectedTestRun) {
      loadTestRunDetails(selectedTestRun);
    }
  }, [selectedTestRun]);

  const stats = getTestStatistics();

  // Колонки таблицы тестов
  const columns = [
    {
      title: 'Тип теста',
      dataIndex: 'test_type',
      key: 'test_type',
      render: (text, record) => (
        <Space direction="vertical" size={0}>
          <Tag color={text === 'simple' ? 'blue' : 'purple'}>
            {text === 'simple' ? 'Простой' : 'Скриптовый'}
          </Tag>
          <Text type="secondary" style={{ fontSize: '12px' }}>
            {record.type}
          </Text>
        </Space>
      ),
      sorter: (a, b) => (a.test_type || '').localeCompare(b.test_type || ''),
    },
    {
      title: 'Название объекта',
      dataIndex: 'object_name',
      key: 'object_name',
      sorter: (a, b) => (a.object_name || '').localeCompare(b.object_name || ''),
    },
    {
      title: 'Переменная',
      dataIndex: 'variable',
      key: 'variable',
      sorter: (a, b) => (a.variable || '').localeCompare(b.variable || ''),
    },
    {
      title: 'Значение',
      dataIndex: 'value',
      key: 'value',
      render: (text) => <Tag color="geekblue">{text}</Tag>,
    },
    {
      title: 'Результат',
      dataIndex: 'result',
      key: 'result',
      render: (result) => {
        const config = getResultStatus(result);
        return (
          <Tag icon={config.icon} color={config.color}>
            {config.label}
          </Tag>
        );
      },
      sorter: (a, b) => {
        const order = { VALID: 1, UNKNOWN: 2, INVALID: 3, ERROR: 4, generated: 5 };
        return (order[a.result] || 6) - (order[b.result] || 6);
      },
    },
    {
      title: 'Описание',
      dataIndex: 'description',
      key: 'description',
      ellipsis: true,
      render: (text) => (
        <Tooltip title={text}>
          <Text style={{ fontSize: '12px' }}>{text}</Text>
        </Tooltip>
      ),
    },
  ];

  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Header style={{ 
        background: '#001529', 
        padding: '0 24px',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center'
      }}>
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <ExperimentOutlined style={{ fontSize: '24px', color: '#fff', marginRight: '12px' }} />
          <Title level={4} style={{ color: '#fff', margin: 0 }}>
            Автоматизированная система проверки ПАК
          </Title>
        </div>
        <Space>
          <Button 
            type="default" 
            icon={<BugOutlined />}
            onClick={() => {
              setSingleTestModalVisible(true);
              setTestResult(null);
              singleTestForm.resetFields();
              setSelectedStationForTest('');
              setAvailableTypes([]);
              setAvailableObjects([]);
              setAvailableVariables([]);
              setAvailableValues([]);
            }}
            style={{ background: '#52c41a', borderColor: '#52c41a', color: '#fff' }}
          >
            Создать тест
          </Button>
          <Button 
            type="primary" 
            icon={<PlusOutlined />}
            onClick={() => setModalVisible(true)}
          >
            Создать запуск
          </Button>
          <Button 
            icon={<ReloadOutlined />}
            onClick={loadTestRuns}
          >
            Обновить
          </Button>
          <Popconfirm
            title="Удалить все тесты"
            description="Вы уверены, что хотите удалить все тестовые запуски? Это действие нельзя отменить."
            onConfirm={deleteAllTests}
            okText="Да"
            cancelText="Нет"
          >
            <Button danger icon={<DeleteOutlined />}>
              Очистить все
            </Button>
          </Popconfirm>
        </Space>
      </Header>

      <Layout>
        <Sider width={350} style={{ background: '#f0f2f5' }}>
          <div style={{ padding: '16px' }}>
            <Title level={5}>Тестовые запуски</Title>
            <Divider style={{ margin: '12px 0' }} />
            {loading ? (
              <div style={{ textAlign: 'center', padding: '40px' }}>
                <Spin size="large" />
              </div>
            ) : testRuns.length === 0 ? (
              <Empty description="Нет тестовых запусков" />
            ) : (
              <List
                dataSource={testRuns}
                renderItem={(testRun) => (
                  <List.Item
                    key={testRun.id}
                    onClick={() => handleSelectTestRun(testRun)}
                    style={{
                      cursor: 'pointer',
                      padding: '12px',
                      marginBottom: '8px',
                      background: selectedTestRun?.id === testRun.id ? '#e6f7ff' : '#fff',
                      borderRadius: '8px',
                      border: selectedTestRun?.id === testRun.id ? '1px solid #1890ff' : '1px solid #d9d9d9',
                      transition: 'all 0.3s'
                    }}
                  >
                    <List.Item.Meta
                      title={
                        <Space>
                          <DatabaseOutlined />
                          <Text strong>{testRun.station}</Text>
                          <Badge count={testRun.count} showZero color="blue" />
                        </Space>
                      }
                      description={
                        <>
                          <Text type="secondary" style={{ fontSize: '12px' }}>
                            ID: {testRun.id}
                          </Text>
                          <br />
                          <Text type="secondary" style={{ fontSize: '12px' }}>
                            Запуск: {formatDate(testRun.start_time)}
                          </Text>
                        </>
                      }
                    />
                  </List.Item>
                )}
              />
            )}
          </div>
        </Sider>

        <Layout style={{ padding: '24px' }}>
          <Content>
            {selectedTestRun ? (
              <>
                <Card style={{ marginBottom: '24px' }}>
                  <Row gutter={16}>
                    <Col span={8}>
                      <Statistic
                        title="Станция"
                        value={selectedTestRun.station}
                        prefix={<DatabaseOutlined />}
                      />
                    </Col>
                    <Col span={8}>
                      <Statistic
                        title="Всего тестов"
                        value={selectedTestRun.count}
                        prefix={<ExperimentOutlined />}
                      />
                    </Col>
                    <Col span={8}>
                      <Statistic
                        title="Последнее обновление"
                        value={lastUpdate ? lastUpdate.toLocaleTimeString('ru-RU') : '—'}
                        prefix={<SyncOutlined spin={autoRefresh} />}
                      />
                    </Col>
                  </Row>
                  <Divider />
                  <Row gutter={16}>
                    <Col span={8}>
                      <Statistic
                        title="Время запуска"
                        value={formatDate(selectedTestRun.start_time)}
                        prefix={<ClockCircleOutlined />}
                      />
                    </Col>
                    <Col span={8}>
                      <Space direction="vertical" style={{ width: '100%' }}>
                        <Text>Автообновление (10 сек)</Text>
                        <Switch
                          checked={autoRefresh}
                          onChange={setAutoRefresh}
                          checkedChildren="Вкл"
                          unCheckedChildren="Выкл"
                        />
                      </Space>
                    </Col>
                    <Col span={8}>
                      <Button
                        type="primary"
                        size="large"
                        icon={<PlayCircleOutlined />}
                        onClick={() => runTests(selectedTestRun.id)}
                        loading={loading || loadingTests}
                        style={{ width: '100%' }}
                      >
                        Запустить все тесты
                      </Button>
                    </Col>
                  </Row>
                </Card>

                {/* Статистика результатов */}
                {tests.length > 0 && (
                  <Card style={{ marginBottom: '24px' }}>
                    <Title level={5}>Статистика результатов</Title>
                    <Row gutter={16}>
                      <Col span={6}>
                        <Statistic
                          title="Всего"
                          value={stats.total}
                          suffix="тестов"
                        />
                      </Col>
                      <Col span={6}>
                        <Statistic
                          title="VALID"
                          value={stats.valid}
                          valueStyle={{ color: '#52c41a' }}
                          prefix={<CheckCircleOutlined />}
                        />
                      </Col>
                      <Col span={6}>
                        <Statistic
                          title="INVALID"
                          value={stats.invalid}
                          valueStyle={{ color: '#ff4d4f' }}
                          prefix={<CloseCircleOutlined />}
                        />
                      </Col>
                      <Col span={6}>
                        <Statistic
                          title="ERROR"
                          value={stats.error}
                          valueStyle={{ color: '#8c8c8c' }}
                          prefix={<ExclamationCircleOutlined />}
                        />
                      </Col>
                    </Row>
                    <Row gutter={16} style={{ marginTop: 16 }}>
                      <Col span={6}>
                        <Statistic
                          title="GENERATED"
                          value={stats.generated}
                          valueStyle={{ color: '#1890ff' }}
                          prefix={<SyncOutlined />}
                        />
                      </Col>
                      <Col span={6}>
                        <Statistic
                          title="UNKNOWN"
                          value={stats.unknown}
                          valueStyle={{ color: '#faad14' }}
                          prefix={<ClockCircleOutlined />}
                        />
                      </Col>
                    </Row>
                  </Card>
                )}

                {/* Таблица тестов */}
                <Card 
                  title="Результаты тестов"
                  extra={
                    <Space>
                      <Text type="secondary">
                        {autoRefresh ? 'Автообновление активно' : 'Автообновление выключено'}
                      </Text>
                      <Button
                        size="small"
                        icon={<ReloadOutlined />}
                        onClick={refreshCurrentTestRun}
                        loading={loadingTests}
                      >
                        Обновить сейчас
                      </Button>
                    </Space>
                  }
                >
                  <Spin spinning={loadingTests}>
                    <Table
                      columns={columns}
                      dataSource={tests}
                      rowKey="id"
                      pagination={{
                        pageSize: 10,
                        showSizeChanger: true,
                        showTotal: (total) => `Всего ${total} тестов`
                      }}
                      scroll={{ x: 1000 }}
                    />
                  </Spin>
                </Card>
              </>
            ) : (
              <Card>
                <Empty
                  description="Выберите тестовый запуск из списка слева"
                  style={{ padding: '60px 0' }}
                />
              </Card>
            )}
          </Content>
        </Layout>
      </Layout>

      {/* Модальное окно создания тестового запуска */}
      <Modal
        title="Создание тестового запуска"
        open={modalVisible}
        onCancel={() => {
          setModalVisible(false);
          form.resetFields();
        }}
        footer={null}
        width={500}
      >
        <Form
          form={form}
          layout="vertical"
          onFinish={generateTestRun}
          initialValues={{ count: 3 }}
        >
          <Form.Item
            name="station"
            label="Название станции"
            rules={[{ required: true, message: 'Пожалуйста, введите название станции' }]}
          >
            <Input placeholder="Например: Балашиха" size="large" />
          </Form.Item>

          <Form.Item
            name="count"
            label="Количество тестов"
            rules={[{ required: true, message: 'Пожалуйста, укажите количество тестов' }]}
          >
            <InputNumber
              min={1}
              max={100}
              style={{ width: '100%' }}
              size="large"
              placeholder="Количество тестов"
            />
          </Form.Item>

          <Form.Item>
            <Space style={{ width: '100%', justifyContent: 'flex-end' }}>
              <Button onClick={() => {
                setModalVisible(false);
                form.resetFields();
              }}>
                Отмена
              </Button>
              <Button type="primary" htmlType="submit" loading={loading}>
                Создать
              </Button>
            </Space>
          </Form.Item>
        </Form>
      </Modal>

      {/* Модальное окно создания одиночного теста */}
      <Modal
        title="Создание одиночного теста"
        open={singleTestModalVisible}
        onCancel={() => {
          setSingleTestModalVisible(false);
          setTestResult(null);
          singleTestForm.resetFields();
          setSelectedStationForTest('');
          setAvailableTypes([]);
          setAvailableObjects([]);
          setAvailableVariables([]);
          setAvailableValues([]);
        }}
        footer={null}
        width={800}
      >
        <Form
          form={singleTestForm}
          layout="vertical"
          onFinish={createAndRunSingleTest}
        >
          <Row gutter={16}>
            <Col span={12}>
              <Form.Item
                name="station"
                label="Станция"
                rules={[{ required: true, message: 'Введите название станции' }]}
              >
                <Input 
                  placeholder="Например: Балашиха"
                  onChange={(e) => handleStationChange(e.target.value)}
                />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="type"
                label="Тип объекта"
                rules={[{ required: true, message: 'Выберите тип объекта' }]}
              >
                <Select 
                  placeholder="Выберите тип объекта"
                  loading={loadingAggregation}
                  disabled={!selectedStationForTest}
                  onChange={(value) => handleTypeChange(value)}
                  showSearch
                  filterOption={(input, option) =>
                    option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                  }
                >
                  {availableTypes.map(type => (
                    <Option key={type} value={type}>{type}</Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              <Form.Item
                name="object_name"
                label="Название объекта"
                rules={[{ required: true, message: 'Выберите название объекта' }]}
              >
                <Select 
                  placeholder="Выберите название объекта"
                  disabled={availableObjects.length === 0}
                  showSearch
                  filterOption={(input, option) =>
                    option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                  }
                >
                  {availableObjects.map(obj => (
                    <Option key={obj} value={obj}>{obj}</Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="variable"
                label="Переменная"
                rules={[{ required: true, message: 'Выберите переменную' }]}
              >
                <Select 
                  placeholder="Выберите переменную"
                  disabled={availableVariables.length === 0}
                  onChange={handleVariableChange}
                  showSearch
                  filterOption={(input, option) =>
                    option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                  }
                >
                  {availableVariables.map(variable => (
                    <Option key={variable} value={variable}>{variable}</Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              <Form.Item
                name="value"
                label="Значение"
                rules={[{ required: true, message: 'Выберите значение' }]}
              >
                <Select 
                  placeholder="Выберите значение"
                  disabled={availableValues.length === 0}
                  showSearch
                  filterOption={(input, option) =>
                    option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                  }
                >
                  {availableValues.map(val => (
                    <Option key={val.value} value={val.value}>
                      {val.value} - {val.description}
                    </Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="value_for_setup"
                label="Значение для настройки (опционально)"
              >
                <Input placeholder="Например: NO_ROUTE, AUTO_OFF" />
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              <Form.Item
                name="test_interval"
                label="Интервал теста (опционально)"
              >
                <Input placeholder="Например: 5.5" />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="wait_seconds"
                label="Секунд ожидания (опционально)"
              >
                <Input placeholder="Например: 2.5" />
              </Form.Item>
            </Col>
          </Row>

          {/* Отображение результата теста */}
          {testResult && (
            <Card 
              size="small" 
              style={{ 
                marginBottom: 16, 
                background: testResult.status === 'error' ? '#fff2f0' : '#f6ffed',
                borderColor: testResult.status === 'error' ? '#ffccc7' : '#b7eb8f'
              }}
            >
              <Space direction="vertical" style={{ width: '100%' }}>
                <Text strong>Результат выполнения:</Text>
                {testResult.status === 'error' ? (
                  <>
                    <Tag icon={<CloseCircleOutlined />} color="error">
                      Ошибка
                    </Tag>
                    <Text type="danger">{testResult.message}</Text>
                  </>
                ) : (
                  <>
                    <Space>
                      <Tag icon={getResultStatus(testResult.result).icon} color={getResultStatus(testResult.result).color}>
                        {testResult.result}
                      </Tag>
                      <Text type="secondary">ID теста: {testResult.test_id}</Text>
                    </Space>
                    <Text type="success">{testResult.message}</Text>
                  </>
                )}
              </Space>
            </Card>
          )}

          <Form.Item>
            <Space style={{ width: '100%', justifyContent: 'flex-end' }}>
              <Button onClick={() => {
                setSingleTestModalVisible(false);
                setTestResult(null);
                singleTestForm.resetFields();
                setSelectedStationForTest('');
                setAvailableTypes([]);
                setAvailableObjects([]);
                setAvailableVariables([]);
                setAvailableValues([]);
              }}>
                Отмена
              </Button>
              <Button type="primary" htmlType="submit" loading={loading}>
                Создать и запустить
              </Button>
            </Space>
          </Form.Item>
        </Form>
      </Modal>
    </Layout>
  );
}

export default App;