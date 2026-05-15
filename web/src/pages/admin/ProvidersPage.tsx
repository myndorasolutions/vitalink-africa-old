import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';

const providers = [
  { id: 'pr1', name: 'City Pharmacy', type: 'pharmacy', status: 'verified' },
  { id: 'pr2', name: 'Dr. Adebayo', type: 'clinician', status: 'verified' },
  { id: 'pr3', name: 'MedLab NG', type: 'lab', status: 'pending' },
];

export function AdminProvidersPage() {
  return (
    <>
      <PageHeader title="Providers" subtitle="Onboarding and verification" />
      <DataTable keyField="id" data={providers} columns={[
        { key: 'name', header: 'Name' },
        { key: 'type', header: 'Type' },
        { key: 'status', header: 'Status' },
      ]} />
    </>
  );
}
