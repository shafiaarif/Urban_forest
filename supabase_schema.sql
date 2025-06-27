

-- ---------------------------
-- USERS TABLE
-- ---------------------------
create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  guest_id text unique not null,
  name text,
  created_at timestamptz default now()
);

alter table users enable row level security;

create policy "Guests can insert themselves"
  on users for insert
  using (true);

-- ---------------------------
-- REVIEWS TABLE
-- ---------------------------
create table if not exists reviews (
  id uuid primary key default gen_random_uuid(),
  guest_id text references users(guest_id),
  name text,
  rating integer not null,
  comment text,
  submitted_at timestamptz default now()
);

alter table reviews enable row level security;

create policy "Anyone can insert reviews"
  on reviews for insert
  using (true);

-- ---------------------------
-- CONTENT TABLE
-- ---------------------------
create table if not exists content (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title_en text,
  title_ur text,
  content_en text,
  content_ur text,
  image_path text,
  updated_at timestamptz default now()
);

alter table content enable row level security;

create policy "Public can view content"
  on content for select
  using (true);
