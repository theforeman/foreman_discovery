import React from 'react';
import { Icon } from 'patternfly-react';
import {
  EmptyState,
  EmptyStateVariant,
  EmptyStateBody,
  EmptyStateActions,
  EmptyStateHeader,
  EmptyStateFooter,
} from '@patternfly/react-core';
import { emptyStatePatternPropTypes } from './EmptyStatePropTypes';
import { translate as __ } from '../../../common/I18n';

const EmptyStatePattern = props => {
  const {
    documentation,
    action,
    secondaryActions,
    iconType,
    icon,
    header,
    description,
  } = props;

  const DocumentationBlock = () => {
    if (!documentation) {
      return null;
    }
    // The documentation prop can also be a customized node
    if (React.isValidElement(documentation)) {
      return documentation;
    }
    const {
      label = __('For more information please see '), // eslint-disable-line react/prop-types
      buttonLabel = __('documentation'), // eslint-disable-line react/prop-types
      url, // eslint-disable-line react/prop-types
    } = documentation;
    return (
      <span>
        {label}
        <a href={url}>{buttonLabel}</a>
      </span>
    );
  };

  return (
    <EmptyState variant={EmptyStateVariant.xl}>
      <span className="empty-state-icon">
        {/* TODO: Add pf4 icons, Redmine issue: #30865 */}
        <Icon name={icon} type={iconType} size="2x" />
      </span>
      <EmptyStateHeader titleText={<>{header}</>} headingLevel="h5" />
      <EmptyStateBody>
        <div className="empty-state-description">{description}</div>
        <DocumentationBlock />
      </EmptyStateBody>
      <EmptyStateFooter>
        {action}
        <EmptyStateActions>{secondaryActions}</EmptyStateActions>
      </EmptyStateFooter>
    </EmptyState>
  );
};

EmptyStatePattern.propTypes = emptyStatePatternPropTypes;

EmptyStatePattern.defaultProps = {
  icon: 'add-circle-o',
  secondaryActions: [],
  documentation: {
    url: '#',
  },
  iconType: 'pf',
};

export default EmptyStatePattern;
