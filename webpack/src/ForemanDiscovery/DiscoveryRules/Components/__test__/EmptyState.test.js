import React from 'react';
import { screen } from '@testing-library/react';
import { rtlHelpers } from 'foremanReact/common/testHelpers';

import ForemanEmptyState from '../EmptyState';

const docUrl = 'https://foreman.example.com';

describe('ForemanEmptyState', () => {
  it('renders discovery rules empty state content', () => {
    rtlHelpers.renderWithStore(<ForemanEmptyState docUrl={docUrl} />);

    expect(
      screen.getByRole('heading', { name: 'Discovery Rules', level: 5 })
    ).toBeInTheDocument();
    expect(
      screen.getByText(
        'No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts'
      )
    ).toBeInTheDocument();
    expect(
      screen.getByText('For more information please see')
    ).toBeInTheDocument();

    const docLink = screen.getByRole('link', { name: 'documentation' });
    expect(docLink).toHaveAttribute('href', docUrl);
    expect(docLink).toHaveAttribute('target', '_blank');
    expect(docLink).toHaveAttribute('rel', 'external noreferrer noopener');

    const actionButton = screen.getByText('Create Rule');
    expect(actionButton).toBeInTheDocument();
    expect(actionButton).toHaveAttribute(
      'data-ouia-component-id',
      'empty-state-action-button'
    );
  });
});
