-- Sample events for local testing with valid, hotlink-friendly CDN links
INSERT INTO events (image_url, title, description, latitude, longitude, year, difficulty)
VALUES
    -- 1. Fall of the Berlin Wall
    (
        'https://images.unsplash.com/photo-1599946347371-68eb71b16afc?auto=format&fit=crop&w=1200&q=80',
        'Fall of the Berlin Wall',
        'Crowds gather at the Brandenburg Gate as the Berlin Wall falls.',
        52.5163, 13.3777, 1989, 2
    ),
    -- 2. Operation Crossroads Nuclear Test
    (
        'https://images.unsplash.com/photo-1518156677180-95a2893f3e9f?auto=format&fit=crop&w=1200&q=80',
        'Operation Crossroads Nuclear Test',
        'An atomic bomb test at Bikini Atoll during the early Cold War.',
        11.5858, 165.3853, 1946, 4
    ),
    -- 3. Raising the Flag on Iwo Jima
    (
        'https://images.unsplash.com/photo-1773434008045-a690b7c88c22?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8UmFpc2luZyUyMHRoZSUyMEZsYWclMjBvbiUyMEl3byUyMEppbWF8ZW58MHx8MHx8fDA%3D',
        'Raising the Flag on Iwo Jima',
        'US Marines raise the American flag atop Mount Suribachi.',
        24.7580, 141.2917, 1945, 3
    ),
    -- 4. Tiananmen Square Protests
    (
        'https://images.unsplash.com/photo-1771068239668-4380d0678b3b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'Tiananmen Square Protests',
        'Pro-democracy demonstrations culminate in a historic standoff in Beijing.',
        39.9042, 116.3975, 1989, 3
    ),
    -- 5. Apollo 11 Launch
    (
        'https://images.unsplash.com/photo-1517976487492-5750f3195933?auto=format&fit=crop&w=1200&q=80',
        'Apollo 11 Launch',
        'The Saturn V rocket lifts off, carrying the first crewed Moon landing mission.',
        28.5729, -80.6490, 1969, 1
    ),
    -- 6. Discovery of Machu Picchu
    (
        'https://images.unsplash.com/photo-1509216242873-7786f446f465?auto=format&fit=crop&w=1200&q=80',
        'Discovery of Machu Picchu',
        'Explorer Hiram Bingham encounters the lost Incan citadel hidden high in the Andes.',
        -13.1631, -72.5450, 1911, 2
    ),
    -- 7. Dedication of the Eiffel Tower
    (
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=1200&q=80',
        'Dedication of the Eiffel Tower',
        'The centerpiece of the World''s Fair officially opens to the public in Paris.',
        48.8584, 2.2945, 1889, 1
    ),
    -- 8. Discovery of King Tutankhamun''s Tomb
    (
        'https://images.unsplash.com/photo-1600577916048-804c9191e36c?auto=format&fit=crop&w=1200&q=80',
        'Discovery of Tutankhamun''s Tomb',
        'Howard Carter breaks through into an intact ancient Egyptian royal burial chamber.',
        25.7401, 32.6018, 1922, 4
    ),
    -- 9. Signing of the Magna Carta
    (
        'https://images.unsplash.com/photo-1569336415962-a4bd9f69cd83?auto=format&fit=crop&w=1200&q=80',
        'Signing of the Magna Carta',
        'King John seals the historic charter of rights under pressure from rebel barons at Runnymede.',
        51.4442, -0.5653, 1215, 5
    ),
    -- 10. Construction of the Taj Mahal Begins
    (
        'https://images.unsplash.com/photo-1564507592333-c60657eea523?auto=format&fit=crop&w=1200&q=80',
        'Construction of the Taj Mahal Begins',
        'Emperor Shah Jahan commissions a massive white marble mausoleum along the Yamuna River.',
        27.1751, 78.0421, 1632, 3
    );