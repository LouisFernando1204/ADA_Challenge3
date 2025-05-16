//
//  ModelData.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import Foundation

@Observable
class ModelData {
    var profile: Profile
    var personalities: [Personality]
    var strengths: [Strength]
    var projects: [Project]
    var tools: [Tool]
    var routines: [Routine]
    var workStyles: [WorkStyle]
    static let shared = ModelData()
    
    private init() {
        self.profile = Profile(
            name: "Gabriella Natasya Pingky Davis",
            role: "3D Modeler",
            age: 25,
            hometown: "Surabaya",
            bio: "Gabriella Natasya, often called Bella, is a passionate 3D Modeler from Surabaya who studied Animation at Limkokwing University of Creative Technology, Malaysia. She has worked on various animated projects such as Oddbods, Antiks, and Minibods during her time at One Animation, showcasing her skills in 3D asset creation and basic rigging using tools like Blender, Maya, and ZBrush.",
            contacts: [
                Contact(
                    type: "LinkedIn",
                    username: "Gabriella Natasya Pingky Davis",
                    urlContact: "linkedin.com/in/gabriellanatasya/",
                    image: "LinkedInLogo"
                ),
                Contact(
                    type: "Instagram",
                    username: "dixallonsy",
                    urlContact: "https://www.instagram.com/dixallonsy/",
                    image: "InstagramLogo"
                ),
                Contact(
                    type: "Email",
                    username: "gabriellanatasya28@gmail.com",
                    urlContact: "mailto:gabriellanatasya28@gmail.com",
                    image: "EmailLogo"
                )
            ],
            image: "BellaProfilePicture"
        )
        
        self.personalities = [
            Personality(
                name: "Waveboarding",
                type: "Hobby",
                reason: "I’ve never been into other sports 🏀❌, but waveboarding just clicks for me! 🛹 It’s fast, fun, and gives me that adrenaline rush I secretly crave ⚡😆.",
                image: "Waveboard"
            ),
            Personality(
                name: "Pizza",
                type: "Fav Food",
                reason: "It’s all about the cheese 🧀😋! That stretchy, melty goodness makes every bite feel like a warm hug 🍕💛.",
                image: "Pizza"
            ),
            Personality(
                name: "Mission Impossible",
                type: "Fav Movie",
                reason: "I love how intense the action scenes are 🔥💥! The choreography is like a fast-paced dance, and I’m always at the edge of my seat 👀🎬.",
                image: "MissionImpossiblePoster"
            ),
            Personality(
                name: "David Tennant",
                type: "Fav Artist",
                reason: "Ever since I saw him in Doctor Who 🚀👨‍🚀, I was hooked! His acting is super animated 🎭 and expressive, plus he's not on social media, so no red flags detected 😂❤️.",
                image: "DavidTennant"
            ),
            Personality(
                name: "Short Haircut",
                type: "Fun Fact",
                reason: "I once cut my hair short ✂️👩‍🎤 just so I could dye it like Storm from X-Men ⚡💙. Zero regrets—felt like a total superhero moment!",
                image: "ShortHairCut"
            )
        ]
        
        self.strengths = [
            Strength(
                name: "Reliable",
                recommendations: [
                    Colleague(
                        name: "Listya U. Harjadi",
                        role: "Asset Supervisor at One Animation",
                        recommendationLetter: "Bella is a 3D modeling artist whose spirit and eagerness to learn and challenge herself should not be underestimated.\nShe quickly adapted to the style of our shows and the speed of work here not long after she joined One Animation. Bella showed a lot of enthusiasm in improving her work and is open to feedback, also not hesitating to ask questions to make sure that she goes on the right direction while fulfilling her tasks. She takes initiative to help with other urgent tasks while making sure that she completes her already assigned tasks first, showing her good sense of responsibility. Furthermore, she is a great team-player who forms a good relationship with her team-mates.\nI am confident that Bella would continue to grow into an even stronger artist and will perform her duties very well wherever she works next.",
                        image: "Colleague_1"
                    ),
                    Colleague(
                        name: "Risal Prakasa",
                        role: "3D Artist with Expertise in Animation & Game Development",
                        recommendationLetter: "Bella is an amazing newcomer in our studio. His speed and management time surprised me when we were on the same project. Those skills made the project go smoothly and easier.\nIt's a pleasure to work with you, I hope we can work together again and you can go through this moment, and come back with beautiful 3D art later. Once again, thank you so much for everything bel!",
                        image: "Colleague_2"
                    ),
                    Colleague(
                        name: "Yudha Dharma Satria",
                        role: "3D Vehicle Artist | 3D Modeler | Freelancer | Former Lead Asset Department @One Animation",
                        recommendationLetter: "Bella is a very passionate 3D modeler, she is very reliable, she understands pipelines, and she also understands how to manage time so that her work can be completed according to the deadline. I know Bella as a junior who is very, very positive, especially her attitude is very nice.\nShe can work under pressure, and can work together with a team, I admire her because she is open to new knowledge and I am sure that wherever she working on other company, she will be a figure who can be relied on.\nThanks, Bella, it's a pleasure to work with you.",
                        image: "Colleague_3"
                    )
                ],
                icon: "ReliableIcon"
            ),
            Strength(
                name: "Eager Learner",
                recommendations: [
                    Colleague(
                        name: "Listya U. Harjadi",
                        role: "Asset Supervisor at One Animation",
                        recommendationLetter: "Bella is a 3D modeling artist whose spirit and eagerness to learn and challenge herself should not be underestimated.\nShe quickly adapted to the style of our shows and the speed of work here not long after she joined One Animation. Bella showed a lot of enthusiasm in improving her work and is open to feedback, also not hesitating to ask questions to make sure that she goes on the right direction while fulfilling her tasks. She takes initiative to help with other urgent tasks while making sure that she completes her already assigned tasks first, showing her good sense of responsibility. Furthermore, she is a great team-player who forms a good relationship with her team-mates.\nI am confident that Bella would continue to grow into an even stronger artist and will perform her duties very well wherever she works next.",
                        image: "Colleague_1"
                    ),
                    Colleague(
                        name: "Andri Viyono",
                        role: "3D Artist",
                        recommendationLetter: "Bella was a junior modeler in the team. But, I was very impressed with her curiosity to learn about new things. She is a very talented and fast learner. Her skills is growing rapidly in the past 1 year. And i believe, she can be a valuable artist in her next studio.",
                        image: "Colleague_4"
                    ),
                    Colleague(
                        name: "Yudha Dharma Satria",
                        role: "3D Vehicle Artist | 3D Modeler | Freelancer | 3D Artist | Former Lead Asset Department @One Animation | Experience at Animation Industry for over 10 years",
                        recommendationLetter: "Bella is a very passionate 3D modeler, she is very reliable, she understands pipelines, and she also understands how to manage time so that her work can be completed according to the deadline. I know Bella as a junior who is very, very positive, especially her attitude is very nice.\nShe can work under pressure, and can work together with a team, I admire her because she is open to new knowledge and I am sure that wherever she working on other company, she will be a figure who can be relied on.\nThanks, Bella, it's a pleasure to work with you.",
                        image: "Colleague_3"
                    )
                ],
                icon: "EagerLearnerIcon"
            ),
            Strength(
                name: "Team Player",
                recommendations: [
                    Colleague(
                        name: "Listya U. Harjadi",
                        role: "Asset Supervisor at One Animation",
                        recommendationLetter: "Bella is a 3D modeling artist whose spirit and eagerness to learn and challenge herself should not be underestimated.\nShe quickly adapted to the style of our shows and the speed of work here not long after she joined One Animation. Bella showed a lot of enthusiasm in improving her work and is open to feedback, also not hesitating to ask questions to make sure that she goes on the right direction while fulfilling her tasks. She takes initiative to help with other urgent tasks while making sure that she completes her already assigned tasks first, showing her good sense of responsibility. Furthermore, she is a great team-player who forms a good relationship with her team-mates.\nI am confident that Bella would continue to grow into an even stronger artist and will perform her duties very well wherever she works next.",
                        image: "Colleague_1"
                    ),
                    Colleague(
                        name: "Yudha Dharma Satria",
                        role: "3D Vehicle Artist | 3D Modeler | Freelancer | 3D Artist | Former Lead Asset Department @One Animation | Experience at Animation Industry for over 10 years",
                        recommendationLetter: "Bella is a very passionate 3D modeler, she is very reliable, she understands pipelines, and she also understands how to manage time so that her work can be completed according to the deadline. I know Bella as a junior who is very, very positive, especially her attitude is very nice.\nShe can work under pressure, and can work together with a team, I admire her because she is open to new knowledge and I am sure that wherever she working on other company, she will be a figure who can be relied on.\nThanks, Bella, it's a pleasure to work with you.",
                        image: "Colleague_3"
                    )
                ],
                icon: "TeamPlayerIcon"
            )
        ]
        
        self.projects = [
            Project(
                title: "Oddbods Specials - Santa Swap",
                projectLocation: "One Animation",
                year: "2022",
                description: "Santa Swap is a holiday-themed animated special from the Oddbods series. In this episode, the lovable and quirky characters of Oddbods find themselves caught in a festive mix-up involving Santa Claus. With signature humor and heart, the story delivers fun-filled chaos and Christmas cheer as the characters try to save the holiday.",
                role: "As a 3d Modeler in this project, my role was to model assets needed for the episode. I modelled an environment of Santa's basement that Fuse used to train as a Santa. Beside that I also modelled several assets on Santa's workshop and the market.",
                thumbnail: "OddbodsSantaSwapThumbnail",
                projectVideoId: "c1Im-C5juIo",
                images: ["SantaSwap_1", "SantaSwap_2"]
            ),
            Project(
                title: "Minibods - Reach for the Star",
                projectLocation: "One Animation",
                year: "2023",
                description: "Minibods is a spin-off from the original Oddbods universe, featuring younger, cuter versions of the Oddbods characters. Aimed at a preschool audience, the series focuses on simple, relatable adventures that teach positive social values through humor and visual storytelling.",
                role: "As a 3d modeller I worked on the pre-production of the series and involved in modelling Pogo's playground. Beside that, I was also involved in several episodes of the series like Halloween Treats Hunt, Reach for the Star, Snowhoof and others.",
                thumbnail: "MinibodsThumbnail",
                projectVideoId: "JNLExw9HAVI",
                images: ["Minibods_1", "Minibods_2"]
            ),
            Project(
                title: "Antiks - The Race",
                projectLocation: "One Animation",
                year: "2023",
                description: "Antiks is a short-form animated series following two adventurous bugs, Joey and Boo as they explore the human world from a tiny perspective. Packed with curiosity, physical comedy, and imaginative storytelling, Antiks is designed for a younger audience and features fast-paced episodes with no dialogue.",
                role: "In this series I worked on new 3d models of several episodes and make sure that animator have the needed assets on each episodes. Few of the episodes includes, The Race, Spider Baby, and Cup Noodle.",
                thumbnail: "AntiksThumbnail",
                projectVideoId: "XsrEqQ-_AUQ",
                images: ["Antiks_1", "Antiks_2"]
            ),
            Project(
                title: "Oddbods Season 4",
                projectLocation: "One Animation",
                year: "2023",
                description: "The fourth season of Oddbods continues the award-winning, non-dialogue comedy series featuring seven unique characters, each with their own personalities and quirks. The show is known globally for its visual humor, vibrant animation, and universal appeal.",
                role: "In this season pre-production, I worked on Zee's house. Several episodes that I worked on includes Mother's Day Meltdown, Halloween Break Outbreak.",
                thumbnail: "OddbodsSeason4Thumbnail",
                projectVideoId: "xpjOpsyhp6c",
                images: ["OddbodsS4_1", "OddbodsS4_2"]
            ),
        ]
        
        self.tools = [
            Tool(
                name: "Blender",
                image: "BlenderLogo"
            ),
            Tool(
                name: "Autodesk Maya",
                image: "AutodeskMayaLogo"
            ),
            Tool(
                name: "ZBrush",
                image: "ZBrushLogo"
            )
        ]
        
        self.routines = [
            Routine(
                title: "Wake up and breakfast",
                time: "06:00 AM"
            ),
            Routine(
                title: "Start work from home and check today's assets",
                time: "10:00 AM"
            ),
            Routine(
                title: "Take a short break",
                time: "01:00 PM"
            ),
            Routine(
                title: "Review and fix assets if needed",
                time: "02:00 PM"
            ),
            Routine(
                title: "Dailies for asset review (if scheduled)",
                time: "04:00 PM"
            ),
            Routine(
                title: "Wrap up work for the day",
                time: "07:00 PM"
            ),
            Routine(
                title: "Go to sleep",
                time: "09:00 PM"
            )
        ]
        
        self.workStyles = [
            WorkStyle(
                title: "🛠️ Hands-On Problem Solver",
                description: "I learn best by doing—whether it’s fixing things or exploring systems, it helps me stay focused and truly understand how things work."
            ),
            WorkStyle(
                title: "🎯 Independent and Focused",
                description: "I work best alone, with space to think and act freely. I stay efficient by focusing on what matters and avoiding unnecessary distractions."
            ),
            WorkStyle(
                title: "🌪️ Adaptive Under Pressure",
                description: "I stay alert in stressful moments. I may overthink sometimes, but it helps me stay prepared and make careful, well-thought-out decisions."
            )
        ]
    }
}
