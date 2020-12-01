import { testComponentSnapshotsWithFixtures } from '@theforeman/test';
import ForemanEmptyState from '../EmptyState';

const action = {
  title: 'action-title',
  url: `action-url`,
};

const fixtures = {
  'render with Props': {
    docUrl: 'https://foreman.example.com',
    action,
  },
};

describe('ForemanEmptyState', () => {
  describe('rendering', () =>
    testComponentSnapshotsWithFixtures(ForemanEmptyState, fixtures));
});
