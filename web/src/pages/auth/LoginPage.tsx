import { FormEvent, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useMutation } from '@tanstack/react-query';
import { LogoFooter } from '@/components/LogoFooter';
import { getRoleHome } from '@/components/Sidebar';
import { mockApi } from '@/lib/mockApi';
import { useAuthStore } from '@/stores/authStore';

const demoAccounts = [
  { email: 'pharmacy@vitalink.demo', label: 'Pharmacy' },
  { email: 'doctor@vitalink.demo', label: 'Clinician' },
  { email: 'lab@vitalink.demo', label: 'Lab' },
  { email: 'admin@vitalink.demo', label: 'Admin' },
  { email: 'superadmin@vitalink.demo', label: 'Super Admin' },
  { email: 'tunde.caregiver@vitalink.demo', label: 'Caregiver' },
  { email: 'grace.patient@vitalink.demo', label: 'Patient' },
];

export function LoginPage() {
  const navigate = useNavigate();
  const setAuth = useAuthStore((s) => s.setAuth);
  const [email, setEmail] = useState('admin@vitalink.demo');
  const [password, setPassword] = useState('DemoPass123!');

  const login = useMutation({
    mutationFn: () => mockApi.login(email, password),
    onSuccess: ({ token, user }) => {
      setAuth(token, user);
      navigate(getRoleHome(user.role));
    },
  });

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    login.mutate();
  };

  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-br from-primary/5 to-slate-100 px-4">
      <div className="w-full max-w-md rounded-2xl border border-slate-200 bg-white p-8 shadow-lg">
        <div className="mb-8 flex items-center justify-center gap-6">
          <img src="/vitalink-logo.jpeg" alt="VitaLink Africa" className="h-14 object-contain" />
          <img src="/myndora-logo.png" alt="Myndora" className="h-10 object-contain" />
        </div>
        <h1 className="text-center text-xl font-bold text-slate-900">Sign in to VitaLink</h1>
        <p className="mt-1 text-center text-sm text-slate-500">
          Chronic care coordination for Nigeria
        </p>

        <form onSubmit={onSubmit} className="mt-8 space-y-4">
          <div>
            <label className="label" htmlFor="email">
              Email
            </label>
            <input
              id="email"
              type="email"
              className="input"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div>
            <label className="label" htmlFor="password">
              Password
            </label>
            <input
              id="password"
              type="password"
              className="input"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          {login.isError && (
            <p className="text-sm text-danger">Sign in failed. Check credentials.</p>
          )}
          <button type="submit" className="btn-primary w-full" disabled={login.isPending}>
            {login.isPending ? 'Signing in…' : 'Sign in'}
          </button>
        </form>

        <div className="mt-6">
          <p className="mb-2 text-xs font-medium uppercase text-slate-400">Demo accounts</p>
          <div className="flex flex-wrap gap-2">
            {demoAccounts.map((acc) => (
              <button
                key={acc.email}
                type="button"
                className="rounded-full border border-slate-200 px-2 py-1 text-xs hover:border-primary hover:text-primary"
                onClick={() => setEmail(acc.email)}
              >
                {acc.label}
              </button>
            ))}
          </div>
        </div>
      </div>
      <LogoFooter className="mt-8" />
    </div>
  );
}
