import React from 'react';
import PropTypes from 'prop-types';
import { translate as __ } from 'foremanReact/common/I18n';
import ForemanEmptyState from 'foremanReact/components/common/EmptyState';

const EmptyState = props => {
  const description = __(
    'No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.'
  );
  const documentation = {
    url: props.docUrl,
  };
  return (
    <ForemanEmptyState
      header={__('Foreman Discovery')}
      description={description}
      icon="gears"
      iconType="fa"
      documentation={documentation}
    />
  );
};

EmptyState.propTypes = {
  docUrl: PropTypes.string.isRequired,
};

export default EmptyState;
