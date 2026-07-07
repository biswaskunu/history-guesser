-- Sample events for local testing. Not real production content 
INSERT INTO events (image_url, title, description, latitude, longitude, year, difficulty)
VALUES
    (
        'https://upload.wikimedia.org/wikipedia/commons/8/8e/Fall_of_the_Berlin_Wall%2C_West_and_East_Germans_at_the_Brandenburg_Gate_in_1989.jpg',
        'Fall of the Berlin Wall',
        'Crowds gather at the Brandenburg Gate as the Berlin Wall falls.',
        52.5163, 13.3777, 1989, 2
    ),
    (
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Baker_Day_One.jpg/640px-Baker_Day_One.jpg',
        'Operation Crossroads Nuclear Test',
        'An atomic bomb test at Bikini Atoll during the early Cold War.',
        11.5858, 165.3853, 1946, 4
    ),
    (
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Raising_the_Flag_on_Iwo_Jima%2C_larger.jpg/640px-Raising_the_Flag_on_Iwo_Jima%2C_larger.jpg',
        'Raising the Flag on Iwo Jima',
        'US Marines raise the American flag atop Mount Suribachi.',
        24.7580, 141.2917, 1945, 3
    ),
    (
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Tank_Man_%28Tiananmen_Square_protester%29.jpg/480px-Tank_Man_%28Tiananmen_Square_protester%29.jpg',
        'Tiananmen Square Protests',
        'A lone protester stands in front of a column of tanks.',
        39.9042, 116.3975, 1989, 3
    ),
    (
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Apollo_11_Launch_-_GPN-2000-000630.jpg/640px-Apollo_11_Launch_-_GPN-2000-000630.jpg',
        'Apollo 11 Launch',
        'The Saturn V rocket lifts off, carrying the first crewed Moon landing mission.',
        28.5729, -80.6490, 1969, 1
    );