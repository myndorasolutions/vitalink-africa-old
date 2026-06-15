export type ReviewStatus = 'needs_review' | 'reviewed' | 'closed';

export interface FlaggedVitalReview {
  id: string;
  patientName: string;
  systolic: number;
  diastolic: number;
  riskStatus: 'green' | 'yellow' | 'red';
  status: ReviewStatus;
  clinicianNotes: string;
  createdAt: string;
}

export const initialReviewQueue: FlaggedVitalReview[] = [
  {
    id: 'rv-1',
    patientName: 'Grace Okafor',
    systolic: 172,
    diastolic: 108,
    riskStatus: 'red',
    status: 'needs_review',
    clinicianNotes: '',
    createdAt: new Date().toISOString(),
  },
  {
    id: 'rv-2',
    patientName: 'Musa Ibrahim',
    systolic: 148,
    diastolic: 94,
    riskStatus: 'yellow',
    status: 'needs_review',
    clinicianNotes: '',
    createdAt: new Date(Date.now() - 3600000).toISOString(),
  },
];
