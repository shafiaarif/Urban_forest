#path :app/api/admin/add-content/route.ts


import { NextResponse } from 'next/server';
import { addContent } from '@/lib/content';

// POST /api/admin/add-content
export async function POST(req: Request) {
  try {
    const body = await req.json();

    const inserted = await addContent(body);

    return NextResponse.json({ success: true, data: inserted });
  } catch (error: any) {
    return NextResponse.json({ success: false, error: error.message }, { status: 400 });
  }
}
