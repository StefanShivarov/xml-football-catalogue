<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fb="http://www.example.com/football" version="2.0">
   <xsl:output method="html" encoding="UTF-8" indent="yes" />
   <xsl:template match="/fb:catalogue">
      <html class="dark">
         <head>
            <title>Football Teams</title>
            <script src="https://cdn.tailwindcss.com" />
            <style>@keyframes gradient-border {
            0% {
              border-color: #58EFEC;
            }
            25% {
              border-color: #7CCAD5;
            }
            50% {
              border-color: #A0A6BE;
            }
            75% {
              border-color: #C481A7;
            }
            100% {
              border-color: #E85C90;
            }
          }

          .gradient-border {
            border-width: 1px;
            border-style: dashed;
            animation: gradient-border 4s infinite;
          }</style>
         </head>
         <body class="font-sans text-gray-300 bg-black">
            <div class="container mx-auto p-6">
               <h1 class="text-5xl font-extrabold text-center mb-12 text-transparent bg-clip-text bg-gradient-to-r from-purple-400 via-pink-500 to-red-500">Football Teams</h1>
               <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                  <xsl:apply-templates select="fb:teams/fb:team" />
               </div>
            </div>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="fb:team">
      <div class="team-card bg-gray-800 rounded-xl shadow-lg overflow-hidden transform transition duration-500 hover:scale-105 gradient-border">
         <div class="team-logo">
            <img class="w-full h-48 object-cover" alt="Team Logo">
               <xsl:choose>
                  <xsl:when test="fb:logo/@src">
                     <xsl:attribute name="src">
                        <xsl:value-of select="fb:logo/@src" />
                     </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="src">https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
            </img>
         </div>
         <div class="team-info p-6">
            <h2 class="team-name text-2xl font-bold text-white mb-3">
               <xsl:value-of select="fb:name" />
            </h2>
            <p class="team-country text-sm text-gray-400">
               <xsl:value-of select="fb:country" />
               -
               <xsl:value-of select="fb:city" />
            </p>
            <p class="team-founded text-sm text-gray-400">
               Founded:
               <xsl:value-of select="fb:founded" />
            </p>
            <div class="team-players mt-6">
               <h3 class="text-lg font-semibold text-purple-400">Players</h3>
               <xsl:apply-templates select="fb:players/fb:player" />
            </div>
            <div class="team-coach mt-6">
               <h3 class="text-lg font-semibold text-green-400">Coach</h3>
               <xsl:apply-templates select="fb:coach" />
            </div>
         </div>
      </div>
   </xsl:template>
   <xsl:template match="fb:player">
      <div class="player flex items-center gap-4 mt-4">
         <img class="w-12 h-12 rounded-full border-2 border-purple-500 object-cover" src="{fb:image/@src}" alt="Player Image">
            <xsl:choose>
               <xsl:when test="fb:image/@src">
                  <xsl:attribute name="src">
                     <xsl:value-of select="fb:image/@src" />
                  </xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="src">https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </img>
         <div>
            <p class="player-name text-white font-medium">
               <xsl:value-of select="fb:name" />
            </p>
            <p class="player-position text-sm text-gray-400">
               Positions:
               <xsl:for-each select="fb:positions/fb:position">
                  <span class="inline-block px-2 py-1 mr-1 bg-gradient-to-r from-purple-500 to-blue-500 text-xs text-white rounded-lg shadow-md">
                     <xsl:value-of select="." />
                  </span>
               </xsl:for-each>
            </p>
         </div>
      </div>
   </xsl:template>
   <xsl:template match="fb:coach">
      <div class="coach flex items-center gap-4 mt-4">
         <img class="w-14 h-14 rounded-full border-2 border-green-400 object-cover" src="{fb:image/@src}" alt="Coach Image">
            <xsl:choose>
               <xsl:when test="fb:image/@src">
                  <xsl:attribute name="src">
                     <xsl:value-of select="fb:image/@src" />
                  </xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="src">https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-1024x499-muqmchqg.png</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </img>
         <div>
            <p class="coach-name text-white font-medium">
               <xsl:value-of select="fb:name" />
            </p>
            <p class="coach-nationality text-sm text-gray-400">
               Nationality:
               <xsl:value-of select="fb:nationality" />
            </p>
         </div>
      </div>
   </xsl:template>
</xsl:stylesheet>