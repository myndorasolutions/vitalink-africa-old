import { Body, Controller, Post, Req } from '@nestjs/common';
import { UserRole } from '@prisma/client';
import { Request } from 'express';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { Roles } from '../auth/decorators/roles.decorator';
import { AuthUser } from '../auth/interfaces/auth-user.interface';
import { CreateVitalDto } from '../vitals/dto/create-vital.dto';
import { RemoteChecksService } from './remote-checks.service';

@Controller('remote-checks')
export class RemoteChecksController {
  constructor(private readonly remoteChecksService: RemoteChecksService) {}

  @Post()
  @Roles(UserRole.patient, UserRole.caregiver, UserRole.chw, UserRole.clinician)
  create(
    @Body() dto: CreateVitalDto,
    @CurrentUser() user: AuthUser,
    @Req() req: Request,
  ) {
    return this.remoteChecksService.createRemoteCheck(dto, user, req);
  }
}
