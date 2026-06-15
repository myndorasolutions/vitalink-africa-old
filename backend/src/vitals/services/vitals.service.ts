import { Injectable, NotFoundException } from '@nestjs/common';
import {
  CaptureLocationType,
  VitalSourceType,
} from '@prisma/client';
import { AuthUser } from '../../auth/interfaces/auth-user.interface';
import { PrismaService } from '../../prisma/prisma.service';
import { calculateRiskStatus, CreateVitalDto } from '../dto/create-vital.dto';

interface CreateContext {
  ipAddress: string;
  userAgent: string;
}

@Injectable()
export class VitalsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreateVitalDto, actor: AuthUser, _ctx: CreateContext) {
    const patientId = dto.patient_id ?? actor.userId;
    const patient = await this.prisma.patient.findUnique({
      where: { id: patientId },
    });
    if (!patient) {
      throw new NotFoundException(`Patient not found: ${patientId}`);
    }

    const riskStatus = calculateRiskStatus(dto.systolic_bp, dto.diastolic_bp);
    const vital = await this.prisma.vital.create({
      data: {
        patientId,
        systolicBp: dto.systolic_bp,
        diastolicBp: dto.diastolic_bp,
        pulse: dto.pulse,
        glucoseFasting: dto.glucose_fasting,
        glucoseRandom: dto.glucose_random,
        weightKg: dto.weight_kg,
        symptoms: dto.symptoms ?? [],
        medicationTaken: dto.medication_taken ?? false,
        notes: dto.notes,
        riskStatus,
        sourceType: dto.source_type ?? VitalSourceType.patient_self,
        capturedByUserId: actor.userId,
        captureLocationType:
          dto.capture_location_type ?? CaptureLocationType.unknown,
      },
    });

    return {
      vital,
      risk_status: riskStatus,
    };
  }
}
