<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore with Ram</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
            color: #333;
        }
        header {
            background: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        nav ul {
            list-style: none;
            padding: 0;
        }
        nav ul li {
            display: inline;
            margin: 0 10px;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
        }
        .section {
            padding: 20px;
            background: #fff;
            margin: 10px 0;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .section h2 {
            margin-top: 0;
        }
        footer {
            text-align: center;
            padding: 10px 0;
            background: #333;
            color: white;
        }
        .contact-form label {
            display: block;
            margin: 5px 0 2px;
        }
        .contact-form input, .contact-form textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
        }
        .contact-form input[type="submit"] {
            background: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header>
        <h1>Explore with Ram</h1>
        <nav>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>
    <div class="section" id="home">
        <h2>Welcome to Explore with Ram</h2>
        <p>Discover the world of technology and innovation with Ram! We offer tutorials, project guidance, and a supportive community for tech enthusiasts.</p>
    </div>
    <div class="section" id="about">
        <h2>About Us</h2>
        <p>Explore with Ram is dedicated to providing the best tutorials and resources to help you navigate the tech world. Our mission is to empower individuals by providing valuable knowledge and skills in various technological fields.</p>
    </div>
    <div class="section" id="services">
        <h2>Our Services</h2>
        <ul>
            <li><strong>Technology Tutorials:</strong> Comprehensive guides and tutorials on the latest technologies.</li>
            <li><strong>Project Guidance:</strong> Get expert advice on your tech projects to ensure success.</li>
            <li><strong>Community Support:</strong> Join a community of like-minded tech enthusiasts and share your experiences.</li>
        </ul>
    </div>
    <div class="section" id="contact">
        <h2>Contact Us</h2>
        <form class="contact-form" action="mailto:justforfun@explorewithram.com" method="post" enctype="text/plain">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email">
            <label for="message">Message:</label>
            <textarea id="message" name="message"></textarea>
            <input type="submit" value="Send">
        </form>
    </div>
    <footer>
        <p>&copy; 2024 Explore with Ram. All rights reserved. Visit us at <a href="http://www.explorewithram.com" style="color: #4CAF50;">www.explorewithram.com</a></p>
    </footer>
</body>
</html>