import {
  CaptureLocationType,
  RiskStatus,
  VitalSourceType,
} from '@prisma/client';
import { IsBoolean, IsEnum, IsInt, IsOptional, IsString } from 'class-validator';

export class CreateVitalDto {
  @IsOptional()
  @IsString()
  patient_id?: string;

  @IsOptional()
  @IsInt()
  systolic_bp?: number;

  @IsOptional()
  @IsInt()
  diastolic_bp?: number;

  @IsOptional()
  @IsInt()
  pulse?: number;

  @IsOptional()
  glucose_fasting?: number;

  @IsOptional()
  glucose_random?: number;

  @IsOptional()
  weight_kg?: number;

  @IsOptional()
  symptoms?: string[];

  @IsOptional()
  @IsBoolean()
  medication_taken?: boolean;

  @IsOptional()
  @IsString()
  notes?: string;

  @IsOptional()
  @IsEnum(VitalSourceType)
  source_type?: VitalSourceType;

  @IsOptional()
  @IsEnum(CaptureLocationType)
  capture_location_type?: CaptureLocationType;
}

export function calculateRiskStatus(
  systolic?: number | null,
  diastolic?: number | null,
): RiskStatus {
  if ((systolic ?? 0) >= 140 || (diastolic ?? 0) >= 90) {
    return RiskStatus.red;
  }
  if ((systolic ?? 0) >= 130 || (diastolic ?? 0) >= 85) {
    return RiskStatus.yellow;
  }
  return RiskStatus.green;
}
