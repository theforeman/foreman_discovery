import { testComponentSnapshotsWithFixtures } from '@theforeman/test';

import ForemanEmptyState from '../EmptyState';

const fixtures = {
  'render with Props': { docUrl: 'https://foreman.example.com' },
};

describe('ForemanEmptyState', () => {
  describe('rendering', () =>
    testComponentSnapshotsWithFixtures(ForemanEmptyState, fixtures));
});
