import { useQuery } from '@tanstack/react-query';
import { useParams } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { VitalsChart } from '@/components/ui/VitalsChart';
import { mockApi } from '@/lib/mockApi';

export function ClinicianPatientChartPage() {
  const { patientId = 'p1' } = useParams();
  const { data: patients } = useQuery({
    queryKey: ['patients'],
    queryFn: () => mockApi.getPatients(),
  });
  const { data: vitals = [] } = useQuery({
    queryKey: ['vitals', patientId],
    queryFn: () => mockApi.getVitalsTrend(patientId, 14),
  });

  const patient = patients?.find((p) => p.id === patientId) ?? patients?.[0];

  return (
    <>
      <PageHeader
        title={patient?.full_name ?? 'Patient chart'}
        subtitle={patient?.conditions.join(' · ')}
        action={patient && <RiskBadge status={patient.risk_status} />}
      />
      <div className="mb-6 grid gap-4 sm:grid-cols-3">
        <div className="card">
          <p className="text-sm text-slate-500">Phone</p>
          <p className="font-medium">{patient?.phone ?? '—'}</p>
        </div>
        <div className="card">
          <p className="text-sm text-slate-500">Last vital</p>
          <p className="font-medium">
            {patient?.last_vital_at
              ? new Date(patient.last_vital_at).toLocaleString('en-NG')
              : '—'}
          </p>
        </div>
        <div className="card">
          <p className="text-sm text-slate-500">Patient ID</p>
          <p className="font-medium">{patientId}</p>
        </div>
      </div>
      <VitalsChart data={vitals} />
    </>
  );
}
