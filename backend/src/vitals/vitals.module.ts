import { Module } from '@nestjs/common';
import { VitalsService } from './services/vitals.service';

@Module({
  providers: [VitalsService],
  exports: [VitalsService],
})
export class VitalsModule {}
