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
    ),
    -- 11. Completion of the Colosseum
    (
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5?auto=format&fit=crop&w=1200&q=80',
        'Completion of the Colosseum',
        'The Flavian Amphitheatre is inaugurated with 100 days of games under Emperor Titus.',
        41.8902, 12.4922, 80, 4
    ),
    -- 12. Assassination of Abraham Lincoln
    (
        'https://images.unsplash.com/photo-1600100717282-127116541f53?auto=format&fit=crop&w=1200&q=80',
        'Assassination of Abraham Lincoln',
        'President Lincoln is shot by John Wilkes Booth at Ford''s Theatre in Washington, D.C.',
        38.8966, -77.0258, 1865, 2
    ),
    -- 13. Sinking of the Titanic
    (
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
        'Sinking of the Titanic',
        'The luxury British ocean liner strikes an iceberg in the North Atlantic on its maiden voyage.',
        41.7269, -49.9482, 1912, 1
    ),
    -- 14. Attack on Pearl Harbor
    (
        'https://images.unsplash.com/photo-1571171637578-41bc2dd4dcd2?auto=format&fit=crop&w=1200&q=80',
        'Attack on Pearl Harbor',
        'A surprise military strike by the Imperial Japanese Navy Air Service triggers US entry into WWII.',
        21.3649, -157.9490, 1941, 2
    ),
    -- 15. Completion of the Great Pyramid of Giza
    (
        'https://images.unsplash.com/photo-1539650116574-8efeb43e2750?auto=format&fit=crop&w=1200&q=80',
        'Completion of the Great Pyramid of Giza',
        'The monumental tomb built for the Fourth Dynasty Pharaoh Khufu is completed.',
        29.9792, 31.1342, -2560, 4
    ),
    -- 16. Coronation of Charlemagne
    (
        'https://images.unsplash.com/photo-1549893072-4bc678117fba?auto=format&fit=crop&w=1200&q=80',
        'Coronation of Charlemagne',
        'Pope Leo III crowns Charlemagne Emperor of the Romans at St. Peter''s Basilica.',
        41.9022, 12.4539, 800, 5
    ),
    -- 17. The Wright Brothers'' First Flight
    (
        'https://images.unsplash.com/photo-1473968512647-3e447244af8f?auto=format&fit=crop&w=1200&q=80',
        'The Wright Brothers'' First Flight',
        'Orville and Wilbur Wright achieve the first controlled, sustained flight of a powered aircraft.',
        36.0142, -75.6706, 1903, 2
    ),
    -- 18. Destruction of Pompeii
    (
        'https://images.unsplash.com/photo-1598539958348-ff81dc2199b0?auto=format&fit=crop&w=1200&q=80',
        'Destruction of Pompeii',
        'Mount Vesuvius erupts catastrophically, burying the Roman city under feet of volcanic ash.',
        40.7512, 14.4869, 79, 3
    ),
    -- 19. Boston Tea Party
    (
        'https://images.unsplash.com/photo-1513151233558-d860c5398176?auto=format&fit=crop&w=1200&q=80',
        'Boston Tea Party',
        'American colonists disguised as Mohawk Indians dump a cargo of British tea into the harbor.',
        42.3524, -71.0505, 1773, 3
    ),
    -- 20. Foundation of Rome
    (
        'https://images.unsplash.com/photo-1531572756148-f3661174bb04?auto=format&fit=crop&w=1200&q=80',
        'Foundation of Rome',
        'Legendary twins Romulus and Remus establish the settlement that would become a global empire.',
        41.8902, 12.4922, -753, 5
    ),
    -- 21. Martin Luther Nails His 95 Theses
    (
        'https://images.unsplash.com/photo-1585857188823-776e8a7c97d7?auto=format&fit=crop&w=1200&q=80',
        'Martin Luther Nails His 95 Theses',
        'The Protestant Reformation begins as Luther challenges church practices at Wittenberg Castle Church.',
        51.8664, 12.6378, 1517, 4
    ),
    -- 22. Opening of the Panama Canal
    (
        'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13?auto=format&fit=crop&w=1200&q=80',
        'Opening of the Panama Canal',
        'The cargo ship SS Ancon officially inaugurates the waterway linking the Atlantic and Pacific oceans.',
        9.1189, -79.6893, 1914, 3
    ),
    -- 23. Assassination of Archduke Franz Ferdinand
    (
        'https://images.unsplash.com/photo-1628127393202-094e9fbd93f0?auto=format&fit=crop&w=1200&q=80',
        'Assassination of Archduke Franz Ferdinand',
        'Gavrilo Princip shoots the heir to the Austro-Hungarian throne in Sarajevo, sparking WWI.',
        43.8579, 18.4287, 1914, 2
    ),
    -- 24. Christopher Columbus Reaches the Americas
    (
        'https://images.unsplash.com/photo-1599733589046-9b8308b5b50d?auto=format&fit=crop&w=1200&q=80',
        'Christopher Columbus Reaches the Americas',
        'The expedition makes landfall in the Caribbean, initiating transatlantic contact.',
        24.0254, -74.4665, 1492, 1
    ),
    -- 25. French Revolution: Storming of the Bastille
    (
        'https://images.unsplash.com/photo-1562615450-4889c1d68305?auto=format&fit=crop&w=1200&q=80',
        'Storming of the Bastille',
        'Revolutionaries storm the medieval fortress and prison, a symbol of royal authority in Paris.',
        48.8532, 2.3698, 1789, 2
    ),
    -- 26. Chernobyl Nuclear Disaster
    (
        'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=1200&q=80',
        'Chernobyl Nuclear Disaster',
        'A flawed reactor system design leads to a catastrophic explosion and fire at the power plant.',
        51.3893, 30.0998, 1986, 2
    ),
    -- 27. Coronation of Queen Elizabeth II
    (
        'https://images.unsplash.com/photo-1569003339405-ea396a5a8a90?auto=format&fit=crop&w=1200&q=80',
        'Coronation of Queen Elizabeth II',
        'The grand ceremony takes place at Westminster Abbey, watched by millions on television.',
        51.4994, -0.1273, 1953, 3
    ),
    -- 28. Opening of the Golden Gate Bridge
    (
        'https://images.unsplash.com/photo-1506012787146-f92b2d7d6d96?auto=format&fit=crop&w=1200&q=80',
        'Opening of the Golden Gate Bridge',
        'The iconic suspension bridge spanning the Golden Gate strait opens to pedestrian traffic.',
        37.8199, -122.4783, 1937, 1
    ),
    -- 29. Nelson Mandela Released from Prison
    (
        'https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&w=1200&q=80',
        'Nelson Mandela Released from Prison',
        'The anti-apartheid activist leaves Victor Verster Prison after 27 years of incarceration.',
        -33.8406, 18.9912, 1990, 3
    ),
    -- 30. Completion of the Great Wall of China (Ming Dynasty Expansion)
    (
        'https://images.unsplash.com/photo-1508873696983-2df519f0397d?auto=format&fit=crop&w=1200&q=80',
        'Ming Expansion of the Great Wall',
        'Major defensive fortifications are finalized to secure northern borders against nomadic raids.',
        40.4319, 116.5704, 1644, 4
    ),
    -- 31. The San Francisco Earthquake
    (
        'https://images.unsplash.com/photo-1536746803623-cef87080bfc8?auto=format&fit=crop&w=1200&q=80',
        'San Francisco Earthquake',
        'A major earthquake and subsequent fires devastate the majority of the California metropolis.',
        37.7749, -122.4194, 1906, 3
    ),
    -- 32. Execution of King Charles I
    (
        'https://images.unsplash.com/photo-1601933973783-43cf8a7d4c5f?auto=format&fit=crop&w=1200&q=80',
        'Execution of King Charles I',
        'Following the English Civil War, the monarch is beheaded for high treason outside Whitehall.',
        51.5042, -0.1263, 1649, 4
    ),
    -- 33. Signing of the United States Declaration of Independence
    (
        'https://images.unsplash.com/photo-1550985543-f47f38aeee65?auto=format&fit=crop&w=1200&q=80',
        'US Declaration of Independence',
        'The Second Continental Congress adopts the historic document at Independence Hall.',
        39.9489, -75.1500, 1776, 2
    ),
    -- 34. The Golden Spike Ceremony (Transcontinental Railroad)
    (
        'https://images.unsplash.com/photo-1474487548417-781cb71495f3?auto=format&fit=crop&w=1200&q=80',
        'The Golden Spike Ceremony',
        'The Union Pacific and Central Pacific railroads are officially joined at Promontory Summit.',
        41.6204, -112.5501, 1869, 4
    ),
    -- 35. Mahatma Gandhi leads the Salt March
    (
        'https://images.unsplash.com/photo-1589182373726-e4f658ab50f0?auto=format&fit=crop&w=1200&q=80',
        'Mahatma Gandhi leads the Salt March',
        'A nonviolent protest campaign against the British salt monopoly begins toward Dandi.',
        22.6416, 72.9372, 1930, 3
    ),
    -- 36. Destruction of the Temple of Jerusalem
    (
        'https://images.unsplash.com/photo-1548702038-8fa3413bc63c?auto=format&fit=crop&w=1200&q=80',
        'Destruction of the Second Temple',
        'Roman legions under Titus breach the walls of Jerusalem and burn down the sacred temple.',
        31.7780, 35.2354, 70, 5
    ),
    -- 37. Martin Luther King Jr. delivers "I Have a Dream" Speech
    (
        'https://images.unsplash.com/photo-1565689157206-0fddef7589a2?auto=format&fit=crop&w=1200&q=80',
        'I Have a Dream Speech',
        'Civil rights leader addresses a massive crowd from the steps of the Lincoln Memorial.',
        38.8893, -77.0502, 1963, 1
    ),
    -- 38. Completion of the Sydney Opera House
    (
        'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?auto=format&fit=crop&w=1200&q=80',
        'Completion of the Sydney Opera House',
        'The masterpiece of expressionist architectural design is officially opened by the Queen.',
        -33.8568, 151.2153, 1973, 2
    ),
    -- 39. The Battle of Waterloo
    (
        'https://images.unsplash.com/photo-1533105079780-92b9be482077?auto=format&fit=crop&w=1200&q=80',
        'The Battle of Waterloo',
        'Napoleon Bonaparte suffers a definitive military defeat by coalition forces in Belgium.',
        50.6789, 4.4053, 1815, 3
    ),
    -- 40. The Treaty of Versailles Signed
    (
        'https://images.unsplash.com/photo-1601579212117-94a0808db39d?auto=format&fit=crop&w=1200&q=80',
        'Treaty of Versailles Signed',
        'The peace treaty that formally concluded World War I is signed inside the Hall of Mirrors.',
        48.8049, 2.1204, 1919, 3
    ),
    -- 41. Boston Marathon Bombing
    (
        'https://images.unsplash.com/photo-1569003339405-ea396a5a8a90?auto=format&fit=crop&w=1200&q=80',
        'Boston Marathon Bombing',
        'Two pressure cooker bombs detonate near the finish line, impacting the historic race.',
        42.3493, -71.0784, 2013, 2
    ),
    -- 42. Fall of Constantinople
    (
        'https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b?auto=format&fit=crop&w=1200&q=80',
        'Fall of Constantinople',
        'The Ottoman Empire breaches the Byzantine capital''s ancient walls, ending the Roman state.',
        41.0082, 28.9784, 1453, 4
    ),
    -- 43. Completion of the Empire State Building
    (
        'https://images.unsplash.com/photo-1522083165195-3427ec02927a?auto=format&fit=crop&w=1200&q=80',
        'Completion of the Empire State Building',
        'The Art Deco skyscraper officially opens in midtown Manhattan during the Great Depression.',
        40.7484, -73.9857, 1931, 2
    ),
    -- 44. Coronation of Napoleon I
    (
        'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?auto=format&fit=crop&w=1200&q=80',
        'Coronation of Napoleon I',
        'Napoleon crowns himself Emperor of the French during a grand ceremony at Notre-Dame.',
        48.8530, 2.3499, 1804, 4
    ),
    -- 45. Invention of the Printing Press by Johannes Gutenberg
    (
        'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1200&q=80',
        'Invention of the Printing Press',
        'Movable type mechanical printing operations begin, transforming global information spread.',
        49.9929, 8.2473, 1440, 5
    ),
    -- 46. The Hindenburg Disaster
    (
        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?auto=format&fit=crop&w=1200&q=80',
        'The Hindenburg Disaster',
        'The German passenger airship catches fire and is destroyed during a landing attempt.',
        40.0333, -74.3236, 1937, 3
    ),
    -- 47. Construction of the Stonehenge Monoliths Completed
    (
        'https://images.unsplash.com/photo-1599839575945-a9e5af0c3fa5?auto=format&fit=crop&w=1200&q=80',
        'Completion of Stonehenge',
        'Prehistoric builders raise the iconic inner circle of massive sarsen standing stones.',
        51.1789, -1.8262, -2500, 5
    ),
    -- 48. Opening of the First Modern Olympic Games
    (
        'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=1200&q=80',
        'Opening of Modern Olympic Games',
        'Athletic events revive ancient traditions at the Panathenaic Stadium in Athens.',
        37.9683, 23.7411, 1896, 3
    ),
    -- 49. Signing of the Magna Carta (Re-confirmation)
    (
        'https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=1200&q=80',
        'Statute of Marlborough',
        'English Parliament passes legislation formalizing land laws, building on Magna Carta principles.',
        51.4194, -1.7306, 1267, 5
    ),
    -- 50. The Great Fire of London
    (
        'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1200&q=80',
        'The Great Fire of London',
        'A major conflagration sweeps through the central parts of the English city from a bakery.',
        51.5101, -0.0859, 1666, 3
    );