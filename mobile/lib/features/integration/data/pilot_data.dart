class PricingTier {
  const PricingTier({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMin,
    required this.priceMax,
  });

  final String id;
  final String name;
  final String description;
  final int priceMin;
  final int priceMax;
}

class ChwProfile {
  const ChwProfile({
    required this.id,
    required this.name,
    required this.area,
    required this.badges,
  });

  final String id;
  final String name;
  final String area;
  final List<String> badges;
}

const pricingTiers = [
  PricingTier(
    id: 'basic_monitor',
    name: 'Basic Monitor',
    description: 'Self-tracking only',
    priceMin: 2000,
    priceMax: 2500,
  ),
  PricingTier(
    id: 'family_care',
    name: 'Family Dashboard',
    description: 'Sponsor visibility + alerts',
    priceMin: 5000,
    priceMax: 7500,
  ),
  PricingTier(
    id: 'assisted_care',
    name: 'Assisted Monitoring',
    description: 'Includes 2–4 remote checks',
    priceMin: 10000,
    priceMax: 15000,
  ),
  PricingTier(
    id: 'premium_chronic',
    name: 'Premium Family Care',
    description: 'Weekly remote checks + clinician review',
    priceMin: 20000,
    priceMax: 35000,
  ),
];

const ilorinChwProfiles = [
  ChwProfile(
    id: 'chw-amina',
    name: 'Amina Bello',
    area: 'Gra, Ilorin',
    badges: ['Identity Verified', 'NIN Verified', 'References Checked', 'Background Check Completed'],
  ),
  ChwProfile(
    id: 'chw-chidi',
    name: 'Chidi Nwosu',
    area: 'Tanke, Ilorin',
    badges: ['Identity Verified', 'NIN Verified', 'References Checked'],
  ),
  ChwProfile(
    id: 'chw-fatima',
    name: 'Fatima Abdullahi',
    area: 'Adewole, Ilorin',
    badges: ['Identity Verified', 'NIN Verified', 'References Checked', 'Background Check Completed'],
  ),
];
