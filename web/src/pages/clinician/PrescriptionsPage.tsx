import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';

const prescriptions = [
  { id: 'rx1', patient: 'Grace Okafor', drug: 'Amlodipine 5mg', sig: '1 tab daily', status: 'sent' },
  { id: 'rx2', patient: 'Esther Adeyemi', drug: 'Metformin 500mg', sig: '1 tab BD', status: 'draft' },
];

export function ClinicianPrescriptionsPage() {
  return (
    <>
      <PageHeader title="Prescriptions" subtitle="E-prescribing workflow" action={<button type="button" className="btn-primary">New Rx</button>} />
      <DataTable
        keyField="id"
        data={prescriptions}
        columns={[
          { key: 'patient', header: 'Patient' },
          { key: 'drug', header: 'Medication' },
          { key: 'sig', header: 'Directions' },
          { key: 'status', header: 'Status' },
        ]}
      />
    </>
  );
}
