const fs = require('fs');
const path = require('path');

try {
    const envPath = path.resolve(__dirname, '.env');
    if (fs.existsSync(envPath)) {
        const envConfig = fs.readFileSync(envPath, 'utf8');
        envConfig.split(/\r?\n/).forEach(line => {
            line = line.trim();
            if (!line || line.startsWith('#')) return;

            let [key, ...valParts] = line.split('=');
            if (key && valParts) {
                let val = valParts.join('=');
                // Remove surrounding quotes if present
                if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
                    val = val.slice(1, -1);
                }
                process.env[key.trim()] = val;
            }
        });
        console.log('Environment variables loaded from .env');
        // Override DB URL for local run (outside Docker)
        if (process.env.DATABASE_URL && process.env.DATABASE_URL.includes('@postgres:')) {
            process.env.DATABASE_URL = process.env.DATABASE_URL.replace('@postgres:', '@127.0.0.1:');
            console.log('Modified DATABASE_URL to use 127.0.0.1');
        }
    }
} catch (err) {
    console.error('Error loading .env:', err);
}

require('./src/server.js');
