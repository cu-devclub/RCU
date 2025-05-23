import { NextRequest, NextResponse } from 'next/server';
import { jwtVerify } from 'jose';

const secret = new TextEncoder().encode(process.env.JWT);

export async function middleware(request: NextRequest) {
  const token = request.cookies.get('authToken')?.value;
  const isRequestToLogin = request.nextUrl.pathname === '/login';
  const isRequestToResetPass = request.nextUrl.pathname === '/forgot-password';

  if (!token && !isRequestToLogin && !isRequestToResetPass) {
    const loginUrl = request.nextUrl.clone();
    loginUrl.pathname = '/login';
    return NextResponse.redirect(loginUrl);
  }

  try {
    if (!token) throw new Error("Missing token");

    const { payload } = await jwtVerify(token, secret);

    // Clone response to set cookies if needed
    const response = NextResponse.next();
    if (typeof payload === 'object' && payload.username && payload.id) {
      response.cookies.set('username', String(payload.username));
      response.cookies.set('userID', String(payload.id));
    }

    if (isRequestToLogin || isRequestToResetPass) {
      const url = request.nextUrl.clone();
      url.pathname = '/';
      return NextResponse.redirect(url);
    }

    return response;
  } catch (err) {
    if (isRequestToLogin || isRequestToResetPass) {
      return NextResponse.next();
    } else {
      const loginUrl = request.nextUrl.clone();
      loginUrl.pathname = '/login';
      return NextResponse.redirect(loginUrl);
    }
  }
}

export const config = {
  matcher: ['/', '/login', '/forgot-password'],
};
