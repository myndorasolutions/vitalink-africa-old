import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { UserRole } from '@prisma/client';
import { Request } from 'express';
import { ROLES_KEY } from '../decorators/roles.decorator';
import { IS_PUBLIC_KEY } from '../decorators/public.decorator';
import { AuthUser } from '../interfaces/auth-user.interface';

@Injectable()
export class DevAuthGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest<Request & { user?: AuthUser }>();
    const authHeader = request.headers.authorization ?? '';
    const token = authHeader.startsWith('Bearer ')
      ? authHeader.slice(7)
      : authHeader;

    if (!token) {
      throw new UnauthorizedException('Missing bearer token');
    }

    const user = this.parseMockToken(token);
    request.user = user;

    const requiredRoles = this.reflector.getAllAndOverride<UserRole[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (requiredRoles?.length && !requiredRoles.includes(user.role)) {
      throw new UnauthorizedException('Insufficient role for this endpoint');
    }

    return true;
  }

  private parseMockToken(token: string): AuthUser {
    if (token.startsWith('mock-jwt-')) {
      const roleKey = token.replace('mock-jwt-', '');
      const role = this.toUserRole(roleKey);
      return {
        userId: `dev-${roleKey}`,
        email: `${roleKey}@myndora.demo`,
        role,
      };
    }

    try {
      const payload = JSON.parse(
        Buffer.from(token.split('.')[0] ?? token, 'base64url').toString('utf8'),
      ) as { uid?: string; email?: string; role?: string };
      return {
        userId: payload.uid ?? 'dev-chw',
        email: payload.email ?? 'chw@myndora.demo',
        role: this.toUserRole(payload.role ?? 'chw'),
      };
    } catch {
      return {
        userId: 'dev-playtest',
        email: 'playtest@myndora.demo',
        role: UserRole.chw,
      };
    }
  }

  private toUserRole(value: string): UserRole {
    const normalized = value.toLowerCase();
    if (Object.values(UserRole).includes(normalized as UserRole)) {
      return normalized as UserRole;
    }
    if (normalized === 'sponsor' || normalized === 'coordinator') {
      return normalized === 'coordinator' ? UserRole.admin : UserRole.caregiver;
    }
    return UserRole.chw;
  }
}
