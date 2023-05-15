import React from 'react';
import PropTypes from 'prop-types';
import { translate as __ } from 'foremanReact/common/I18n';
import ForemanEmptyState from 'foremanReact/components/common/EmptyState';
import { foremanUrl } from 'foremanReact/common/helpers';

const EmptyState = props => {
  const action = {
    title: __('Create Rule'),
    url: foremanUrl('/discovery_rules/new'),
  };
  const description = __(
    'No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts'
  );
  const documentation = {
    url: props.docUrl,
  };
  return (
    <ForemanEmptyState
      header={__('Discovery Rules')}
      description={description}
      icon="gavel"
      iconType="fa"
      documentation={documentation}
      action={action}
    />
  );
};

EmptyState.propTypes = {
  docUrl: PropTypes.string.isRequired,
};

export default EmptyState;
