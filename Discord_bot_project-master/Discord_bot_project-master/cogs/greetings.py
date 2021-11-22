import discord
from discord.ext import commands

class Greetings(commands.Cog):

    def __init__(self, bot):
        self.bot = bot

    @commands.Cog.listener()
    async def on_ready(self):
        print("Greetings is online.")

    @commands.Cog.listener()
    async def on_member_join(self, member):
        print(f'{member} has joined a server.')

    @commands.Cog.listener()
    async def on_member_remove(self, member):
        print(f'{member} has left a server.')







def setup(bot):
    bot.add_cog(Greetings(bot))