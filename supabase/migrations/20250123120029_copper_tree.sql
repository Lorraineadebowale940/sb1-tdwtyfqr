/*
  # Create storage bucket for team photos

  1. New Storage Bucket
    - Create a public bucket for team photos
    - Enable public access for reading images
  
  2. Security
    - Enable RLS on the bucket
    - Add policy for public read access
    - Add policy for authenticated users to upload
*/

-- Create a new public bucket for team photos
INSERT INTO storage.buckets (id, name, public)
VALUES ('team-photos', 'team-photos', true);

-- Enable RLS
CREATE POLICY "Public Access" ON storage.objects
  FOR SELECT
  USING (bucket_id = 'team-photos');

-- Allow authenticated users to upload
CREATE POLICY "Authenticated users can upload" ON storage.objects
  FOR INSERT
  WITH CHECK (
    bucket_id = 'team-photos'
    AND auth.role() = 'authenticated'
  );