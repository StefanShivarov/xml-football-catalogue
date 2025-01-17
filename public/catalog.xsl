<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fb="http://www.example.com/football" version="2.0">
   <xsl:output method="html" encoding="UTF-8" indent="yes" />

   <xsl:template match="/fb:catalogue">
      <html class="dark">
         <head>
            <title>Football Teams Catalogue</title>
            <script src="https://cdn.tailwindcss.com" />
            <style>
               @keyframes gradient-move {
                  0% { background-position: 0% 50%; }
                  50% { background-position: 100% 50%; }
                  100% { background-position: 0% 50%; }
               }

               .animate-gradient-move {
                  background-size: 200% 200%;
                  animation: gradient-move 3s infinite linear;
               }
            </style>
            <script>
               function sortTeamsByName(order) {
                  const teamsContainer = document.getElementById("teams-container");
                  const teams = Array.from(teamsContainer.children);
                  teams.sort((a, b) => {
                     const nameA = a.querySelector("h2").textContent.toLowerCase();
                     const nameB = b.querySelector("h2").textContent.toLowerCase();
                     if (order === "asc") {
                        return nameA.localeCompare(nameB);
                     } else {
                        return nameB.localeCompare(nameA);
                     }
                  });
                  teams.forEach((team) => teamsContainer.appendChild(team));

                  const ascButton = document.getElementById("asc-btn");
                  const descButton = document.getElementById("desc-btn");

                  if (order === "asc") {
                     ascButton.classList.add("border-blue-500");
                     ascButton.classList.remove("border-gray-700");
                     descButton.classList.remove("border-blue-500");
                     descButton.classList.add("border-gray-700");
                  } else {
                     descButton.classList.add("border-blue-500");
                     descButton.classList.remove("border-gray-700");
                     ascButton.classList.remove("border-blue-500");
                     ascButton.classList.add("border-gray-700");
                  }
               }

               function sortTeamsByDomesticCompetition() {
                  console.log("clicked");
                  const teamsContainer = document.getElementById("teams-container");
                  console.log(teamsContainer);
                  const teams = Array.from(teamsContainer.children);
                  console.log(teams);
                  teams.sort((a, b) => {
                     const compA = a.querySelector(".comp-name").textContent.toLowerCase();
                     const compB = b.querySelector(".comp-name").textContent.toLowerCase();
                     return compA.localeCompare(compB);
                  });
                  teams.forEach((team) => teamsContainer.appendChild(team));
               }
            </script>
         </head>
         <body class="font-sans text-gray-300 bg-gradient-to-b from-black to-gray-900">
            <div class="container mx-auto p-6">
               <h1 class="text-4xl font-extrabold text-center mb-8 text-transparent bg-clip-text bg-gradient-to-r from-purple-400 via-pink-500 to-blue-500">Football Teams Catalogue</h1>
               <div class="text-center mb-8">
                  <button id="asc-btn" onclick="sortTeamsByName('asc')" class="px-8 py-4 rounded-full bg-gradient-to-br from-gray-900 via-gray-800 to-black mr-3 text-white font-semibold tracking-wider uppercase border border-gray-700 shadow-[inset_0_-2px_6px_rgba(0,0,0,0.7),_0_2px_8px_rgba(255,255,255,0.1)] hover:shadow-[0_0_15px_2px_rgba(0,100,200,0.5)] hover:border-blue-500 transition-all duration-300 ease-in-out">Sort by team name A-Z</button>
                  <button id="desc-btn" onclick="sortTeamsByName('desc')" class="px-8 py-4 rounded-full bg-gradient-to-br from-gray-900 via-gray-800 to-black mr-3 text-white font-semibold tracking-wider uppercase border border-gray-700 shadow-[inset_0_-2px_6px_rgba(0,0,0,0.7),_0_2px_8px_rgba(255,255,255,0.1)] hover:shadow-[0_0_15px_2px_rgba(0,100,200,0.5)] hover:border-blue-500 transition-all duration-300 ease-in-out">Sort by team name Z-A</button>
                  <button id="sort-by-comp-btn" onclick="sortTeamsByDomesticCompetition()" class="px-8 py-4 rounded-full bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white font-semibold tracking-wider uppercase border border-gray-700 shadow-[inset_0_-2px_6px_rgba(0,0,0,0.7),_0_2px_8px_rgba(255,255,255,0.1)] hover:shadow-[0_0_15px_2px_rgba(0,100,200,0.5)] hover:border-blue-500 transition-all duration-300 ease-in-out">Sort by domestic competition</button>
               </div>
               <div class="grid grid-cols-1 lg:grid-cols-2 gap-8" id="teams-container">
                  <xsl:apply-templates select="fb:teams/fb:team" />
               </div>
            </div>
         </body>
      </html>
   </xsl:template>

   <xsl:template match="fb:team">
      <div class="bg-gray-800 rounded-lg shadow-lg p-6 transform transition relative">
         <div class="flex items-start gap-6 mb-4">
            <div class="relative">
               <div class="w-20 h-20 rounded-full bg-gradient-to-r from-purple-400 via-pink-500 to-blue-500 animate-gradient-move p-1">
                  <img class="w-full h-full rounded-full" alt="Team Logo">
                     <xsl:attribute name="src">
                        <xsl:choose>
                           <xsl:when test="fb:logo/@src">
                              <xsl:value-of select="unparsed-entity-uri(fb:logo/@src)" />
                           </xsl:when>
                           <xsl:otherwise>https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:otherwise>
                        </xsl:choose>
                     </xsl:attribute>
                  </img>
               </div>
            </div>
            <div>
               <h2 class="text-2xl font-bold text-white">
                  <xsl:value-of select="fb:name" />
               </h2>
               <p class="text-sm text-gray-400">
                  <xsl:value-of select="fb:country" />
                  -
                  <xsl:value-of select="fb:city" />
                  | Founded:
                  <xsl:value-of select="fb:founded" />
               </p>
               <p class="text-sm text-gray-400">
                  Stadium: 
                  <xsl:value-of select="fb:stadium" />
               </p>
            </div>
         </div>
         <div class="absolute top-4 right-4 bg-black text-white text-xs font-bold rounded-full px-3 py-1 shadow-md">Coach</div>
         <div class="absolute top-12 right-4 flex items-center gap-3">
            <xsl:apply-templates select="fb:coach" />
         </div>
         <div class="mb-4">
            <h3 class="text-lg font-semibold text-blue-400 mb-2">Competitions</h3>
            <div class="flex flex-wrap gap-3">
               <xsl:apply-templates select="fb:competitionRefs/fb:competitionRef" />
            </div>
         </div>
         <div class="mb-4">
            <h3 class="text-lg font-semibold text-purple-400 mb-2">Players</h3>
            <div class="flex flex-wrap gap-3">
               <xsl:apply-templates select="fb:players/fb:player" />
            </div>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="fb:competitionRef">
      <xsl:variable name="competitionID" select="@ref" />
      <xsl:variable name="competition" select="/fb:catalogue/fb:competitions/fb:competition[@id=$competitionID]" />
      <div class="flex items-center gap-2 bg-gray-700 px-3 py-2 rounded-lg shadow-sm">
         <img class="w-8 h-8 rounded-full border-2 border-blue-500 object-cover" alt="Competition Logo">
            <xsl:attribute name="src">
               <xsl:choose>
                  <xsl:when test="$competition/fb:logo/@src">
                     <xsl:value-of select="unparsed-entity-uri($competition/fb:logo/@src)" />
                  </xsl:when>
                  <xsl:otherwise>https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:otherwise>
               </xsl:choose>
            </xsl:attribute>
         </img>
         <div>
            <p class="text-sm font-medium text-white comp-name">
               <xsl:value-of select="$competition/fb:name" />
            </p>
            <p class="text-xs text-gray-400">
               <xsl:value-of select="$competition/fb:country" />
            </p>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="fb:player">
      <div class="flex items-center gap-2 bg-gray-700 px-3 py-2 rounded-lg shadow-sm">
         <img class="w-8 h-8 rounded-full border-2 border-purple-500 object-cover" alt="Player Image">
         <xsl:attribute name="src">
            <xsl:choose>
               <xsl:when test="fb:image/@src">
                  <xsl:value-of select="unparsed-entity-uri(fb:image/@src)" />
               </xsl:when>
               <xsl:otherwise>https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
      </img>
         <div>
            <p class="text-sm font-medium text-white leading-none mb-1">
               <xsl:value-of select="fb:name" />
            </p>
            <p class="text-xs text-gray-400 mb-1">
               <xsl:value-of select="fb:nationality" />
                 | Age: 
                  <xsl:value-of select="fb:age" />
            </p>
            <p class="text-xs text-gray-400">
               <xsl:for-each select="fb:positions/fb:position">
                  <span class="inline-block px-2 py-0.5 mr-1 bg-gradient-to-r from-purple-500 to-blue-500 text-xs text-white rounded-md">
                     <xsl:value-of select="." />
                  </span>
               </xsl:for-each>
            </p>
         </div>
      </div>
   </xsl:template>
   
   <xsl:template match="fb:coach">
      <div class="flex items-center gap-3">
         <img class="w-10 h-10 rounded-full border-2 border-purple-500 object-cover" alt="Coach Image" >
            <xsl:attribute name="src">
            <xsl:choose>
               <xsl:when test="fb:image/@src">
                  <xsl:value-of select="unparsed-entity-uri(fb:image/@src)" />
               </xsl:when>
               <xsl:otherwise>https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
         </img>
         <div>
            <p class="text-sm font-medium text-white">
               <xsl:value-of select="fb:name" />
            </p>
            <p class="text-xs text-gray-400">
               <xsl:value-of select="fb:nationality" />
               | Age: 
               <xsl:value-of select="fb:age" />
            </p>
         </div>
      </div>
   </xsl:template>

</xsl:stylesheet>