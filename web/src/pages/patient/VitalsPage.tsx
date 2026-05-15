import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { VitalsChart } from '@/components/ui/VitalsChart';
import { mockApi } from '@/lib/mockApi';

export function PatientVitalsPage() {
  const { data = [], isLoading } = useQuery({
    queryKey: ['vitals', 'p1', 30],
    queryFn: () => mockApi.getVitalsTrend('p1', 30),
  });

  return (
    <>
      <PageHeader title="My vitals" subtitle="30-day trends" />
      {isLoading ? <p className="text-slate-500">Loading chart…</p> : <VitalsChart data={data} />}
    </>
  );
}
