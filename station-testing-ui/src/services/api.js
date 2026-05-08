import axios from 'axios';

const api = axios.create({ baseURL: 'http://localhost:8000/api' });

export const TestService = {
  // Тестовые запуски (Test Runs)
  generateRun: (station, count) => api.post(`/generate_test_run`, null, { params: { station, count } }),
  getRuns: (station) => api.get(`/get_tests_runs`, { params: { station } }),
  getRunById: (id_run) => api.get(`/get_tests_runs`, { params: { id_run } }),
  startRun: (id_run) => api.post(`/tests_run`, null, { params: { id_run } }),
  
  // Тесты
  getTests: (station, count = 100) => api.get(`/get_tests_case`, { params: { station, count } }),
  getTestById: (id_test) => api.get(`/get_tests_case`, { params: { id_test } }), // Если добавишь эндпоинт
  runSingleTest: (id_test) => api.post(`/test_run`, null, { params: { id_test } }),

  // Объекты и иерархия
  getStationObjects: (station) => api.get(`/object_test`, { params: { station } }),
  
  // Очистка
  clearDb: () => api.delete(`/drop_tests_collection`)
};
