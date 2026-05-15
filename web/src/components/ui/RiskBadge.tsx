import type { RiskStatus } from '@/lib/types';

const map: Record<RiskStatus, string> = {
  green: 'badge-green',
  yellow: 'badge-yellow',
  red: 'badge-red',
};

export function RiskBadge({ status }: { status: RiskStatus }) {
  return <span className={map[status]}>{status.toUpperCase()}</span>;
}
