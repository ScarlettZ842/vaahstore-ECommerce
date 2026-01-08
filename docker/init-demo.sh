#!/bin/bash
set -e

echo "==================================="
echo "VaahStore Module Demo Setup"
echo "==================================="

# This is a demonstration PHP file to show the module structure
# In production, this would be part of VaahCMS

cat > /var/www/index.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>VaahStore Module</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { color: #333; }
        .module-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 4px;
            margin: 20px 0;
        }
        .warning {
            background: #fff3cd;
            padding: 15px;
            border-radius: 4px;
            border-left: 4px solid #ffc107;
        }
        code {
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
        }
        .endpoints {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
        }
        .endpoint-item {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛒 VaahStore E-Commerce Module</h1>
        
        <div class="module-info">
            <h3>Module Information</h3>
            <?php
            $composerFile = __DIR__ . '/composer.json';
            if (file_exists($composerFile)) {
                $composer = json_decode(file_get_contents($composerFile), true);
                echo "<p><strong>Name:</strong> " . ($composer['name'] ?? 'N/A') . "</p>";
                echo "<p><strong>Description:</strong> " . ($composer['description'] ?? 'N/A') . "</p>";
                echo "<p><strong>Version:</strong> " . ($composer['version'] ?? 'N/A') . "</p>";
            }
            
            echo "<p><strong>PHP Version:</strong> " . phpversion() . "</p>";
            echo "<p><strong>Database:</strong> " . ($_ENV['DB_HOST'] ?? 'localhost') . "</p>";
            ?>
        </div>

        <div class="warning">
            <h3>⚠️ Important Notice</h3>
            <p>This is a <strong>VaahCMS module</strong>, not a standalone application.</p>
            <p>For full functionality, this module should be installed within VaahCMS using:</p>
            <code>npx vaah store:install</code>
        </div>

        <div class="endpoints">
            <h3>Module Structure</h3>
            <div class="endpoint-item">
                <strong>📁 Models:</strong> <?php echo count(glob(__DIR__ . '/Models/*.php')); ?> files
            </div>
            <div class="endpoint-item">
                <strong>📁 Controllers:</strong> <?php echo count(glob(__DIR__ . '/Http/Controllers/*.php')); ?> files
            </div>
            <div class="endpoint-item">
                <strong>📁 Migrations:</strong> <?php echo count(glob(__DIR__ . '/Database/Migrations/*.php')); ?> files
            </div>
            <div class="endpoint-item">
                <strong>📁 Vue Components:</strong> <?php echo file_exists(__DIR__ . '/Vue') ? 'Available' : 'Not found'; ?>
            </div>
        </div>

        <h3>Quick Links</h3>
        <ul>
            <li><a href="http://localhost:5173" target="_blank">Vue.js Development Server (Port 5173)</a></li>
            <li><a href="https://github.com/webreinvent/vaahcms" target="_blank">VaahCMS Documentation</a></li>
        </ul>

        <h3>Available Module Features</h3>
        <ul>
            <li>Product Management</li>
            <li>Category & Brand Management</li>
            <li>Vendor Management</li>
            <li>Order & Payment Processing</li>
            <li>Shopping Cart & Wishlist</li>
            <li>Multi-currency Support</li>
            <li>Warehouse & Inventory Management</li>
        </ul>
    </div>
</body>
</html>
EOF

echo "Demo index.php created successfully!"
echo "Access the application at: http://localhost:8080"
