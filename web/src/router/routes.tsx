import { Navigate, RouteObject } from 'react-router-dom';
import { Layout } from '@/components/Layout';
import { LoginPage } from '@/pages/auth/LoginPage';
import { AdminDashboardPage } from '@/pages/admin/DashboardPage';
import { ChwCheckupPortalPage } from '@/pages/chw/CheckupPortalPage';
import { ClinicianQueuePage } from '@/pages/clinician/QueuePage';
import { ClinicianPatientChartPage } from '@/pages/clinician/PatientChartPage';
import { PatientDashboardPage } from '@/pages/patient/DashboardPage';
import { PatientMedicationsPage } from '@/pages/patient/MedicationsPage';
import { PatientVitalsPage } from '@/pages/patient/VitalsPage';
import { SponsorDashboardPage } from '@/pages/sponsor/DashboardPage';
import { FeatureFlagsPage } from '@/pages/super-admin/FeatureFlagsPage';
import { PricingRulesPage } from '@/pages/super-admin/PricingRulesPage';
import { ProtectedRoute } from './ProtectedRoute';

export const routes: RouteObject[] = [
  { path: '/login', element: <LoginPage /> },
  {
    element: <ProtectedRoute />,
    children: [
      {
        element: <Layout />,
        children: [
          { index: true, element: <Navigate to="/login" replace /> },

          {
            element: <ProtectedRoute roles={['admin']} />,
            children: [{ path: 'admin/dashboard', element: <AdminDashboardPage /> }],
          },

          {
            element: <ProtectedRoute roles={['caregiver']} />,
            children: [{ path: 'sponsor/dashboard', element: <SponsorDashboardPage /> }],
          },

          {
            element: <ProtectedRoute roles={['chw']} />,
            children: [{ path: 'chw/checkup', element: <ChwCheckupPortalPage /> }],
          },

          {
            element: <ProtectedRoute roles={['clinician']} />,
            children: [
              { path: 'clinician/queue', element: <ClinicianQueuePage /> },
              { path: 'clinician/patient/:patientId/chart', element: <ClinicianPatientChartPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['super_admin']} />,
            children: [
              { path: 'super-admin/feature-flags', element: <FeatureFlagsPage /> },
              { path: 'super-admin/pricing-rules', element: <PricingRulesPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['patient']} />,
            children: [
              { path: 'patient/dashboard', element: <PatientDashboardPage /> },
              { path: 'patient/vitals', element: <PatientVitalsPage /> },
              { path: 'patient/medications', element: <PatientMedicationsPage /> },
            ],
          },
        ],
      },
    ],
  },
  { path: '*', element: <Navigate to="/login" replace /> },
];
