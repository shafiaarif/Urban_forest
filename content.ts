#path :src/lib/content.ts


import { supabaseAdmin } from './supabaseAdmin';

export async function addContent(data: {
  slug: string;
  title_en: string;
  title_ur: string;
  content_en: string;
  content_ur: string;
  image_path: string;
}) {
  const { error, data: inserted } = await supabaseAdmin
    .from('content')
    .insert([data]);

  if (error) {
    console.error('Error inserting content:', error.message);
    throw error;
  }

  return inserted;
}
