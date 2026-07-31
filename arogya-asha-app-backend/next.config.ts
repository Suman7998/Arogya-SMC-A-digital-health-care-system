import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Explicitly disable Turbopack and use Webpack
  experimental: {
    turbo: false, // Disable Turbopack
  },
  
  // Ensure proper handling of external packages
  serverExternalPackages: ['firebase-admin'],
  
  // Webpack configuration (optional - for advanced needs)
  webpack: (config, { isServer }) => {
    if (isServer) {
      // Exclude firebase-admin from client bundles
      config.externals = [...(config.externals || []), 'firebase-admin'];
    }
    return config;
  },
};

export default nextConfig;