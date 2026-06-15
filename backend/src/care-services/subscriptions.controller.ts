import { Controller, Get, Param } from '@nestjs/common';
import { UserRole } from '@prisma/client';
import { Roles } from '../auth/decorators/roles.decorator';
import { SubscriptionsService } from './subscriptions.service';

@Controller('subscriptions')
export class SubscriptionsController {
  constructor(private readonly subscriptionsService: SubscriptionsService) {}

  @Get('patient/:patientId')
  @Roles(UserRole.admin, UserRole.clinician, UserRole.chw, UserRole.patient)
  getPatientSubscription(@Param('patientId') patientId: string) {
    return this.subscriptionsService.getPatientSubscription(patientId);
  }
}
