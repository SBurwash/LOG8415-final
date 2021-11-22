import discord
from discord.ext import commands, tasks
import youtube_dl


class Sounds(commands.Cog):

    def __init__(self, bot):
        self.bot = bot

    @commands.Cog.listener()
    async def on_ready(self):
        print("Sounds is online.")

    @commands.command()
    async def join(self, ctx):
        channel = ctx.author.voice.channel
        await channel.connect()

    # @commands.command(help="Ask bot to join a specific channel")
    # async def join_specific_channel(self, *, channel_name):
    #     channel = channel_name
    #     await channel.connect()

    @commands.command()
    async def leave(self, ctx):
        await ctx.voice_client.disconnect()

    @commands.command(aliases=[], help='This comand plays a song')
    async def play(self, ctx, url):
        # if ctx.message.author.voice:
        #     await ctx.send("You are not connected to a voice channel")
        #     return
        channel = ctx.message.author.voice.channel
        await channel.connect()

        server = ctx.guild
        voice_channel = server.voice_client

        async with ctx.typing():
            player = await youtube_dl.from_url(url, self.bot.loop)
            voice_channel.play(player, after=lambda e: print("Player error: %s" %e) if e else None)

        await ctx.send(f"**Now Playing:** {player.title}")

    @commands.command()
    async def stop(self, ctx):
        await ctx.voice_client.disconnect()

def setup(bot):
    bot.add_cog(Sounds(bot))