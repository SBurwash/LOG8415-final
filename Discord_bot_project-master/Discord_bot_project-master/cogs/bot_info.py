import discord
from discord.ext import commands, tasks
from itertools import cycle

status = cycle(['Status 1', 'Status 2'])
class BotInfo(commands.Cog):

    def __init__(self, bot):
        self.bot = bot

    #Status not working
    @commands.Cog.listener()
    async def on_ready(self):
        await self.bot.change_presence(status=discord.Status.idle, activity=discord.Game('Hello there!'))
        self.change_status.start()
        print("Bot Info is online.")

    @tasks.loop(seconds=10)
    async def change_status(self):
        await self.bot.change_presence(activity=discord.Game(next(status)))

def setup(bot):
    bot.add_cog(BotInfo(bot))