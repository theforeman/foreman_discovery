import React from 'react';
import { screen } from '@testing-library/react';
import { rtlHelpers } from 'foremanReact/common/testHelpers';

import ForemanEmptyState from '../EmptyState';

const docUrl = 'https://foreman.example.com';

describe('ForemanEmptyState', () => {
  it('renders discovered hosts empty state content', () => {
    rtlHelpers.renderWithStore(<ForemanEmptyState docUrl={docUrl} />);

    expect(
      screen.getByRole('heading', { name: 'Foreman Discovery', level: 5 })
    ).toBeInTheDocument();
    expect(
      screen.getByText(
        'No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.'
      )
    ).toBeInTheDocument();
    expect(
      screen.getByText('For more information please see')
    ).toBeInTheDocument();

    const docLink = screen.getByRole('link', { name: 'documentation' });
    expect(docLink).toHaveAttribute('href', docUrl);
    expect(docLink).toHaveAttribute('target', '_blank');
    expect(docLink).toHaveAttribute('rel', 'external noreferrer noopener');

    expect(screen.queryByText('Create Rule')).not.toBeInTheDocument();
    expect(
      document.querySelector(
        '[data-ouia-component-id="empty-state-action-button"]'
      )
    ).not.toBeInTheDocument();
  });
});
