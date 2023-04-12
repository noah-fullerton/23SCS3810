import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class Track(Base): 
    __tablename__ = "tracks"
    id = Column(Integer, ForeignKey("albums.id"), primary_key=True)
    num = Column(Integer, primary_key=True)
    name = Column(String)

class Album(Base): 
    __tablename__ = "albums"
    id = Column(Integer, primary_key=True)
    title = Column(String)
    artist = Column(String)
    year = Column(Integer)
    tracks = relationship("Track", primaryjoin="Album.id==Track.id")

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

url = URL.create(
    "postgresql+psycopg2",
    username=params['user'],
    password=params['password'],
    host=params['host'],
    port=params['port'],
    database=params['dbname']
)

engine = create_engine(url)
if engine: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(Album)
    for album in query.all():
        print(album.id, album.title, album.artist, album.year)
        for track in album.tracks:
            print("\t", track.num, track.name)