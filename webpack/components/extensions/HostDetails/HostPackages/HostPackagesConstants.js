export const HOST_PACKAGES_KEY = 'HOST_PACKAGES';
export const HOST_PACKAGES_INSTALL_KEY = 'HOST_PACKAGES_KATELLO_AGENT_INSTALL';
export const HOST_PACKAGES_REMOVE_KEY = 'HOST_PACKAGES_REMOVE';
export const HOST_PACKAGES_UPGRADE_KEY = 'HOST_PACKAGES_UPGRADE';
export const PACKAGES_SEARCH_QUERY = 'Packages search query';

export const PACKAGES_VERSION_STATUSES = {
  UPGRADABLE: 'Upgradable',
  UP_TO_DATE: 'Up-to date',
};

export const VERSION_STATUSES_TO_PARAM = {
  [PACKAGES_VERSION_STATUSES.UPGRADABLE]: 'upgradable',
  [PACKAGES_VERSION_STATUSES.UP_TO_DATE]: 'up-to-date',
};
