import React from 'react';
import { CheckCircleIcon } from '@patternfly/react-icons';
import { translate as __ } from 'foremanReact/common/I18n';
import { foremanUrl } from 'foremanReact/common/helpers';
import { cellWidth } from '@patternfly/react-table';

export const enableFormatter = ({ title: enabled }) => ({
  children: enabled ? <CheckCircleIcon color="green" /> : __('No'),
});

export const cells = [
  {
    title: __('Name'),
    transforms: [cellWidth(10)],
  },
  {
    title: __('Priority'),
    transforms: [cellWidth(10)],
  },
  {
    title: __('Query'),
    transforms: [cellWidth(20)],
  },
  {
    title: __('Host Group'),
    transforms: [cellWidth(10)],
  },
  {
    title: __('Host/Limit'),
    transforms: [cellWidth(10)],
  },
  {
    title: __('Enabled'),
    transforms: [cellWidth(10)],
    cellTransforms: [enableFormatter],
  },
  {
    title: __('Actions'),
    transforms: [cellWidth(20)],
  },
];

export const DISCOVERY_RULES_PATH = foremanUrl('/api/v2/discovery_rules');

export const GET_DISCOVERY_RULES = 'DISCOVERY_RULES';

export const DISCOVERY_RULES_SELECTED_IDS = 'DISCOVERY_RULES_SET_SELECTED_IDS';

export const DISCOVERY_RULES_SELECT_ALL_ALERT =
  'DISCOVERY_RULES_SET_SELECT_ALL_ALERT';

export const DISCOVERY_RULES_SELECT_ALL = 'DISCOVERY_RULES_SET_SELECT_ALL';
