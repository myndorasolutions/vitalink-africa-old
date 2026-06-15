export type PilotRole = 'chw' | 'sponsor' | 'coordinator';

export type SubscriptionPlanId =
  | 'basic_monitor'
  | 'family_care'
  | 'assisted_care'
  | 'premium_chronic';

export interface PricingTier {
  id: SubscriptionPlanId;
  name: string;
  description: string;
  priceMinNaira: number;
  priceMaxNaira: number;
}

export interface ChwTrustBadge {
  id: string;
  label: string;
}

export interface IlorinChwProfile {
  id: string;
  name: string;
  area: string;
  yearsExperience: number;
  badges: ChwTrustBadge['id'][];
}

export const PILOT_ROLES: {
  id: PilotRole;
  title: string;
  subtitle: string;
}[] = [
  {
    id: 'chw',
    title: 'Community Health Worker',
    subtitle: 'Field checkups, Yoruba audio prompts, visit verification',
  },
  {
    id: 'sponsor',
    title: 'Family Sponsor / Subscriber',
    subtitle: 'Plans, CHW assignment, vitals and alert monitoring',
  },
  {
    id: 'coordinator',
    title: 'Administrative Care Coordinator',
    subtitle: 'Trust grids, sync queues, clinician review simulator',
  },
];

export const PRICING_TIERS: PricingTier[] = [
  {
    id: 'basic_monitor',
    name: 'Basic Monitor',
    description: 'Self-tracking only',
    priceMinNaira: 2000,
    priceMaxNaira: 2500,
  },
  {
    id: 'family_care',
    name: 'Family Dashboard',
    description: 'Sponsor visibility + alerts',
    priceMinNaira: 5000,
    priceMaxNaira: 7500,
  },
  {
    id: 'assisted_care',
    name: 'Assisted Monitoring',
    description: 'Includes 2–4 remote checks per month',
    priceMinNaira: 10000,
    priceMaxNaira: 15000,
  },
  {
    id: 'premium_chronic',
    name: 'Premium Family Care',
    description: 'Weekly remote checks + clinician review',
    priceMinNaira: 20000,
    priceMaxNaira: 35000,
  },
];

export const TRUST_BADGES: ChwTrustBadge[] = [
  { id: 'identity', label: 'Identity Verified' },
  { id: 'nin', label: 'NIN Verified' },
  { id: 'references', label: 'References Checked' },
  { id: 'background', label: 'Background Check Completed' },
];

export const ILORIN_CHW_PROFILES: IlorinChwProfile[] = [
  {
    id: 'chw-amina',
    name: 'Amina Bello',
    area: 'Gra, Ilorin',
    yearsExperience: 6,
    badges: ['identity', 'nin', 'references', 'background'],
  },
  {
    id: 'chw-chidi',
    name: 'Chidi Nwosu',
    area: 'Tanke, Ilorin',
    yearsExperience: 4,
    badges: ['identity', 'nin', 'references'],
  },
  {
    id: 'chw-fatima',
    name: 'Fatima Abdullahi',
    area: 'Adewole, Ilorin',
    yearsExperience: 8,
    badges: ['identity', 'nin', 'references', 'background'],
  },
];

export function getPilotHome(role: PilotRole): string {
  switch (role) {
    case 'chw':
      return '/chw/checkup';
    case 'sponsor':
      return '/sponsor/dashboard';
    case 'coordinator':
      return '/admin/dashboard';
  }
}
