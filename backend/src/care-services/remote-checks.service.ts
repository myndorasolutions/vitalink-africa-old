import { Injectable } from '@nestjs/common';
import { VitalSourceType } from '@prisma/client';
import { Request } from 'express';
import { AuthUser } from '../auth/interfaces/auth-user.interface';
import { CreateVitalDto } from '../vitals/dto/create-vital.dto';
import { VitalsService } from '../vitals/services/vitals.service';

@Injectable()
export class RemoteChecksService {
  constructor(private readonly vitalsService: VitalsService) {}

  async createRemoteCheck(
    dto: CreateVitalDto,
    actor: AuthUser,
    req: Request,
  ) {
    const payload: CreateVitalDto = {
      ...dto,
      source_type: dto.source_type ?? VitalSourceType.patient_self,
    };

    const result = await this.vitalsService.create(payload, actor, {
      ipAddress: req.ip ?? 'unknown',
      userAgent: req.headers['user-agent'] ?? 'unknown',
    });

    return {
      service_layer: 'chw_remote_check',
      ...result,
    };
  }
}
