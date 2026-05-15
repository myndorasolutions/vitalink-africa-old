import { NavLink } from 'react-router-dom';
import type { UserRole } from '@/lib/types';
import { useAuthStore } from '@/stores/authStore';

interface NavItem {
  to: string;
  label: string;
  end?: boolean;
}

const navByRole: Record<UserRole, NavItem[]> = {
  pharmacy: [
    { to: '/pharmacy/dashboard', label: 'Dashboard', end: true },
    { to: '/pharmacy/walk-in-check', label: 'Walk-in check' },
    { to: '/pharmacy/refill-queue', label: 'Refill queue' },
    { to: '/pharmacy/refill-fulfillment', label: 'Fulfillment' },
    { to: '/pharmacy/earnings', label: 'Earnings' },
  ],
  clinician: [
    { to: '/clinician/queue', label: 'Queue', end: true },
    { to: '/clinician/patient/p1/chart', label: 'Patient chart' },
    { to: '/clinician/consultation-note', label: 'Consultation note' },
    { to: '/clinician/prescriptions', label: 'Prescriptions' },
    { to: '/clinician/earnings', label: 'Earnings' },
  ],
  lab: [
    { to: '/lab/order-queue', label: 'Order queue', end: true },
    { to: '/lab/orders/lo1', label: 'Order detail' },
    { to: '/lab/result-upload', label: 'Result upload' },
    { to: '/lab/scheduler', label: 'Scheduler' },
  ],
  admin: [
    { to: '/admin/dashboard', label: 'Dashboard', end: true },
    { to: '/admin/patients', label: 'Patients' },
    { to: '/admin/providers', label: 'Providers' },
    { to: '/admin/payments', label: 'Payments' },
    { to: '/admin/compliance', label: 'Compliance' },
    { to: '/admin/reports', label: 'Reports' },
  ],
  super_admin: [
    { to: '/super-admin/feature-flags', label: 'Feature flags', end: true },
    { to: '/super-admin/pricing-rules', label: 'Pricing rules' },
    { to: '/super-admin/clinical-safety', label: 'Clinical safety' },
    { to: '/super-admin/system-config', label: 'System config' },
  ],
  caregiver: [
    { to: '/caregiver/dashboard', label: 'Dashboard', end: true },
    { to: '/caregiver/patients', label: 'My patients' },
    { to: '/caregiver/vitals', label: 'Log vitals' },
  ],
  patient: [
    { to: '/patient/dashboard', label: 'Home', end: true },
    { to: '/patient/vitals', label: 'My vitals' },
    { to: '/patient/medications', label: 'Medications' },
  ],
  home_helper: [
    { to: '/caregiver/dashboard', label: 'Dashboard', end: true },
    { to: '/caregiver/vitals', label: 'Log vitals' },
  ],
  chw: [
    { to: '/caregiver/dashboard', label: 'Dashboard', end: true },
    { to: '/caregiver/patients', label: 'Patients' },
    { to: '/caregiver/vitals', label: 'Log vitals' },
  ],
};

const roleHome: Record<UserRole, string> = {
  pharmacy: '/pharmacy/dashboard',
  clinician: '/clinician/queue',
  lab: '/lab/order-queue',
  admin: '/admin/dashboard',
  super_admin: '/super-admin/feature-flags',
  caregiver: '/caregiver/dashboard',
  patient: '/patient/dashboard',
  home_helper: '/caregiver/dashboard',
  chw: '/caregiver/dashboard',
};

export function getRoleHome(role: UserRole): string {
  return roleHome[role];
}

export function Sidebar() {
  const user = useAuthStore((s) => s.user);
  const logout = useAuthStore((s) => s.logout);
  const items = user ? navByRole[user.role] ?? [] : [];

  return (
    <aside className="flex w-64 flex-col border-r border-slate-200 bg-white">
      <div className="border-b border-slate-200 p-4">
        <img src="/vitalink-logo.jpeg" alt="VitaLink Africa" className="h-10 object-contain" />
        <p className="mt-2 text-xs font-medium uppercase tracking-wide text-primary">
          {user?.role.replace('_', ' ')}
        </p>
      </div>
      <nav className="flex-1 space-y-1 p-3">
        {items.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.end}
            className={({ isActive }) =>
              `block rounded-lg px-3 py-2 text-sm font-medium transition ${
                isActive
                  ? 'bg-primary/10 text-primary'
                  : 'text-slate-600 hover:bg-slate-100'
              }`
            }
          >
            {item.label}
          </NavLink>
        ))}
      </nav>
      <div className="border-t border-slate-200 p-4">
        <p className="truncate text-sm font-medium">{user?.full_name}</p>
        <p className="truncate text-xs text-slate-500">{user?.email}</p>
        <button type="button" onClick={logout} className="btn-outline mt-3 w-full text-xs">
          Sign out
        </button>
      </div>
    </aside>
  );
}
