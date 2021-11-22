import discord
from discord.ext import commands

import random

class Random(commands.Cog):

    def __init__(self, bot):
        self.bot = bot

    @commands.Cog.listener()
    async def on_ready(self):
        print("Random is online.")

    @commands.command(aliases=[], help="This command returns pong")
    async def ping(self, ctx):
        await ctx.send(f"Pong! {round(self.bot.latency * 1000)}ms")

    @commands.command(name='99', help='Responds with a random quote from Brooklyn 99')
    async def nine_nine(self, ctx):

        brooklyn_99_quotes = [
            'I\'m the human form of the 💯 emoji.',
            'Bingpot!',
            (
                'Cool. Cool cool cool cool cool cool cool, '
                'no doubt no doubt no doubt no doubt.'
            ),
        ]

        response = random.choice(brooklyn_99_quotes)
        await ctx.send(response)

    @commands.command(aliases=['8ball'])
    async def _8ball(self, ctx, *, question):

        responses = ['It is certain',
                    'It is decidedly so',
                    'Without a doubt',
                    'Yes – definitely',
                    'You may rely on it',
                    'As I see it, yes',
                    'Most likely',
                    'Outlook good',
                    'Yes Signs point to yes',
                    'Reply hazy',
                    'try again',
                    'Ask again later',
                    'Better not tell you now',
                    'Cannot predict now',
                    'Concentrate and ask again',
                    'Dont count on it',
                    'My reply is no',
                    'My sources say no',
                    'Outlook not so good',
                    'Very doubtful']

        await ctx.send(f'Question: {question}\n Answer: {random.choice(responses)}')


def setup(bot):
    bot.add_cog(Random(bot))