import {
  CartesianGrid,
  Legend,
  Line,
  LineChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import type { VitalReading } from '@/lib/types';

interface VitalsChartProps {
  data: VitalReading[];
  title?: string;
}

export function VitalsChart({ data, title = 'Blood pressure trend' }: VitalsChartProps) {
  const chartData = data.map((v) => ({
    date: new Date(v.recorded_at).toLocaleDateString('en-NG', {
      month: 'short',
      day: 'numeric',
    }),
    systolic: v.systolic_bp,
    diastolic: v.diastolic_bp,
    glucose: v.glucose_fasting,
  }));

  return (
    <div className="card">
      <h3 className="mb-4 font-semibold text-slate-800">{title}</h3>
      <ResponsiveContainer width="100%" height={280}>
        <LineChart data={chartData}>
          <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
          <XAxis dataKey="date" tick={{ fontSize: 12 }} />
          <YAxis tick={{ fontSize: 12 }} />
          <Tooltip />
          <Legend />
          <Line type="monotone" dataKey="systolic" stroke="#00a389" strokeWidth={2} name="Systolic" />
          <Line type="monotone" dataKey="diastolic" stroke="#64748b" strokeWidth={2} name="Diastolic" />
          <Line type="monotone" dataKey="glucose" stroke="#f59e0b" strokeWidth={2} name="Glucose" />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}
