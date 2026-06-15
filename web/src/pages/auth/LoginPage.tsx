import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useMutation } from '@tanstack/react-query';
import { LogoFooter } from '@/components/LogoFooter';
import { mockApi } from '@/lib/mockApi';
import { getPilotHome, PILOT_ROLES, type PilotRole } from '@/lib/pilotData';
import { useAuthStore } from '@/stores/authStore';

export function LoginPage() {
  const navigate = useNavigate();
  const setAuth = useAuthStore((s) => s.setAuth);
  const [selectedRole, setSelectedRole] = useState<PilotRole>('sponsor');

  const login = useMutation({
    mutationFn: () => mockApi.loginWithPilotRole(selectedRole),
    onSuccess: ({ token, user }) => {
      setAuth(token, user);
      navigate(getPilotHome(selectedRole));
    },
  });

  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-br from-primary/5 to-slate-100 px-4 py-8">
      <div className="w-full max-w-lg rounded-2xl border border-slate-200 bg-white p-8 shadow-lg">
        <div className="mb-6 flex justify-center">
          <img
            src="/assets/myndora_care_logo5.jpeg"
            alt="Myndora Care"
            className="h-20 w-auto object-contain"
          />
        </div>
        <h1 className="text-center text-xl font-bold text-slate-900">Myndora Care Pilot</h1>
        <p className="mt-1 text-center text-sm text-slate-500">
          Select your role to enter the closed testing portal
        </p>

        <div className="mt-8">
          <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-400">
            Developer role switcher
          </p>
          <div className="space-y-3">
            {PILOT_ROLES.map((role) => (
              <button
                key={role.id}
                type="button"
                onClick={() => setSelectedRole(role.id)}
                className={`w-full rounded-xl border p-4 text-left transition ${
                  selectedRole === role.id
                    ? 'border-primary bg-primary/5 ring-2 ring-primary/30'
                    : 'border-slate-200 hover:border-primary/40'
                }`}
              >
                <p className="font-semibold text-slate-900">{role.title}</p>
                <p className="mt-1 text-sm text-slate-500">{role.subtitle}</p>
              </button>
            ))}
          </div>
        </div>

        {login.isError && (
          <p className="mt-4 text-sm text-danger">Sign in failed. Please try again.</p>
        )}

        <button
          type="button"
          className="btn-primary mt-6 w-full"
          disabled={login.isPending}
          onClick={() => login.mutate()}
        >
          {login.isPending ? 'Signing in…' : 'Continue as selected role'}
        </button>
      </div>
      <LogoFooter className="mt-8" />
    </div>
  );
}
