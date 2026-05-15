import { Navigate, RouteObject } from 'react-router-dom';
import { Layout } from '@/components/Layout';
import { LoginPage } from '@/pages/auth/LoginPage';
import { AdminCompliancePage } from '@/pages/admin/CompliancePage';
import { AdminDashboardPage } from '@/pages/admin/DashboardPage';
import { AdminPatientsPage } from '@/pages/admin/PatientsPage';
import { AdminPaymentsPage } from '@/pages/admin/PaymentsPage';
import { AdminProvidersPage } from '@/pages/admin/ProvidersPage';
import { AdminReportsPage } from '@/pages/admin/ReportsPage';
import { CaregiverDashboardPage } from '@/pages/caregiver/DashboardPage';
import { CaregiverPatientsPage } from '@/pages/caregiver/PatientsPage';
import { CaregiverVitalsPage } from '@/pages/caregiver/VitalsPage';
import { ClinicianConsultationNotePage } from '@/pages/clinician/ConsultationNotePage';
import { ClinicianEarningsPage } from '@/pages/clinician/EarningsPage';
import { ClinicianPatientChartPage } from '@/pages/clinician/PatientChartPage';
import { ClinicianPrescriptionsPage } from '@/pages/clinician/PrescriptionsPage';
import { ClinicianQueuePage } from '@/pages/clinician/QueuePage';
import { LabOrderDetailPage } from '@/pages/lab/OrderDetailPage';
import { LabOrderQueuePage } from '@/pages/lab/OrderQueuePage';
import { LabResultUploadPage } from '@/pages/lab/ResultUploadPage';
import { LabSchedulerPage } from '@/pages/lab/SchedulerPage';
import { PharmacyDashboardPage } from '@/pages/pharmacy/DashboardPage';
import { PharmacyEarningsPage } from '@/pages/pharmacy/EarningsPage';
import { PharmacyRefillFulfillmentPage } from '@/pages/pharmacy/RefillFulfillmentPage';
import { PharmacyRefillQueuePage } from '@/pages/pharmacy/RefillQueuePage';
import { PharmacyWalkInCheckPage } from '@/pages/pharmacy/WalkInCheckPage';
import { PatientDashboardPage } from '@/pages/patient/DashboardPage';
import { PatientMedicationsPage } from '@/pages/patient/MedicationsPage';
import { PatientVitalsPage } from '@/pages/patient/VitalsPage';
import { ClinicalSafetyPage } from '@/pages/super-admin/ClinicalSafetyPage';
import { FeatureFlagsPage } from '@/pages/super-admin/FeatureFlagsPage';
import { PricingRulesPage } from '@/pages/super-admin/PricingRulesPage';
import { SystemConfigPage } from '@/pages/super-admin/SystemConfigPage';
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
            element: <ProtectedRoute roles={['pharmacy']} />,
            children: [
              { path: 'pharmacy/dashboard', element: <PharmacyDashboardPage /> },
              { path: 'pharmacy/walk-in-check', element: <PharmacyWalkInCheckPage /> },
              { path: 'pharmacy/refill-queue', element: <PharmacyRefillQueuePage /> },
              { path: 'pharmacy/refill-fulfillment', element: <PharmacyRefillFulfillmentPage /> },
              { path: 'pharmacy/earnings', element: <PharmacyEarningsPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['clinician']} />,
            children: [
              { path: 'clinician/queue', element: <ClinicianQueuePage /> },
              { path: 'clinician/patient/:patientId/chart', element: <ClinicianPatientChartPage /> },
              { path: 'clinician/consultation-note', element: <ClinicianConsultationNotePage /> },
              { path: 'clinician/prescriptions', element: <ClinicianPrescriptionsPage /> },
              { path: 'clinician/earnings', element: <ClinicianEarningsPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['lab']} />,
            children: [
              { path: 'lab/order-queue', element: <LabOrderQueuePage /> },
              { path: 'lab/orders/:orderId', element: <LabOrderDetailPage /> },
              { path: 'lab/result-upload', element: <LabResultUploadPage /> },
              { path: 'lab/scheduler', element: <LabSchedulerPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['admin']} />,
            children: [
              { path: 'admin/dashboard', element: <AdminDashboardPage /> },
              { path: 'admin/patients', element: <AdminPatientsPage /> },
              { path: 'admin/providers', element: <AdminProvidersPage /> },
              { path: 'admin/payments', element: <AdminPaymentsPage /> },
              { path: 'admin/compliance', element: <AdminCompliancePage /> },
              { path: 'admin/reports', element: <AdminReportsPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['super_admin']} />,
            children: [
              { path: 'super-admin/feature-flags', element: <FeatureFlagsPage /> },
              { path: 'super-admin/pricing-rules', element: <PricingRulesPage /> },
              { path: 'super-admin/clinical-safety', element: <ClinicalSafetyPage /> },
              { path: 'super-admin/system-config', element: <SystemConfigPage /> },
            ],
          },

          {
            element: <ProtectedRoute roles={['caregiver', 'home_helper', 'chw']} />,
            children: [
              { path: 'caregiver/dashboard', element: <CaregiverDashboardPage /> },
              { path: 'caregiver/patients', element: <CaregiverPatientsPage /> },
              { path: 'caregiver/vitals', element: <CaregiverVitalsPage /> },
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
