from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, sessionmaker, declarative_base

Base = declarative_base()

class PL(Base):

    __tablename__ = 'pls'

    id = Column(Integer, primary_key=True)
    name = Column(String)


    def __str__(self):
        return str(self.id) + ", " + self.name
    

engine = create_engine('sqlite:///pls.db')
if engine:
    print("connection was successful")
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(PL)
    for pl in query.all():
        print(pl.id, pl.name)