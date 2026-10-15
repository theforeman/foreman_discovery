const path = require('path');

const foreman = path.resolve(__dirname, '../foreman');

module.exports = {
  rootDir: __dirname,
  setupFilesAfterEnv: [
    require.resolve('@testing-library/jest-dom', { paths: [foreman] }),
  ],
  moduleDirectories: [`${foreman}/node_modules`, 'node_modules'],
  resolver: null,
};
