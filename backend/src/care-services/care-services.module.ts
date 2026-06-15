import { Module } from '@nestjs/common';
import { VitalsModule } from '../vitals/vitals.module';
import { ChwVisitsController } from './chw-visits.controller';
import { ChwVisitsService } from './chw-visits.service';
import { RemoteChecksController } from './remote-checks.controller';
import { RemoteChecksService } from './remote-checks.service';
import { SubscriptionsController } from './subscriptions.controller';
import { SubscriptionsService } from './subscriptions.service';

@Module({
  imports: [VitalsModule],
  controllers: [
    SubscriptionsController,
    RemoteChecksController,
    ChwVisitsController,
  ],
  providers: [SubscriptionsService, RemoteChecksService, ChwVisitsService],
})
export class CareServicesModule {}
